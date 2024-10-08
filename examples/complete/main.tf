// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

data "aws_caller_identity" "current" {}

module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 1.0"

  for_each = var.resource_names_map

  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  region                  = join("", split("-", var.region))
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  instance_resource       = var.resource_number
  maximum_length          = each.value.max_length
}

module "cloudwatch_log_subscription_filter" {
  source = "../.."

  subscription_filter_name                = module.resource_names["subscription_filter"].standard
  subscription_filter_role_arn            = module.producer_role.assumable_iam_role
  cloudwatch_log_group_name               = module.resource_names["log_group"].standard
  subscription_filter_delivery_stream_arn = module.firehose_delivery_stream.arn
}

module "cloudwatch_log_group" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_primitive-cloudwatch_log_group?ref=1.0.1"

  name = module.resource_names["log_group"].standard
}

module "cloudwatch_log_stream" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_primitive-cloudwatch_log_stream?ref=1.0.1"

  name                      = module.resource_names["log_stream"].standard
  cloudwatch_log_group_name = module.resource_names["log_group"].standard
  depends_on                = [module.cloudwatch_log_group]
}

module "firehose_delivery_stream" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_primitive-firehose_delivery_stream?ref=1.1.0"

  delivery_stream_name   = module.resource_names["delivery_stream"].standard
  http_endpoint_url      = var.http_endpoint_url
  http_endpoint_name     = var.http_endpoint_name
  s3_error_output_prefix = var.s3_error_prefix
  s3_endpoint_bucket_arn = module.s3_bucket.arn
  consumer_role_arn      = module.consumer_role.assumable_iam_role

  tags = { resource_name = module.resource_names["delivery_stream"].standard }
}

module "s3_bucket" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_collection-s3_bucket?ref=1.0.0"

  enable_versioning = true
}

module "producer_role" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_collection-iam_assumable_role?ref=1.0.1"

  environment        = var.environment
  environment_number = var.environment_number
  region             = var.region
  resource_number    = var.resource_number

  assume_iam_role_policies = [data.aws_iam_policy_document.producer_policy.json]
  trusted_role_services    = local.producer_trusted_services
  role_sts_externalid      = local.producer_external_id

  resource_names_map = {
    iam_policy = var.resource_names_map["producer_policy"]
    iam_role   = var.resource_names_map["producer_role"]
  }
}

data "aws_iam_policy_document" "producer_policy" {
  statement {
    sid    = "StreamInteractions"
    effect = "Allow"
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch"
    ]
    resources = [
      "arn:aws:firehose:${var.region}:${local.account_id}:deliverystream/${module.resource_names["delivery_stream"].standard}"
    ]
  }
}

module "consumer_role" {
  source = "git::https://github.com/launchbynttdata/tf-aws-module_collection-iam_assumable_role?ref=1.0.1"

  environment        = var.environment
  environment_number = var.environment_number
  region             = var.region
  resource_number    = var.resource_number

  assume_iam_role_policies = [data.aws_iam_policy_document.consumer_policy.json]
  trusted_role_services    = local.consumer_trusted_services
  role_sts_externalid      = local.consumer_external_id

  resource_names_map = {
    iam_policy = var.resource_names_map["consumer_policy"]
    iam_role   = var.resource_names_map["consumer_role"]
  }
}

data "aws_iam_policy_document" "consumer_policy" {
  statement {
    sid    = "FailedLogsS3Interactions"
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]
    resources = [
      module.s3_bucket.arn,
      "${module.s3_bucket.arn}/*"
    ]
  }

  statement {
    sid    = "PutLogEvents"
    effect = "Allow"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream"
    ]
    resources = [
      module.cloudwatch_log_group.log_group_arn
    ]
  }

  statement {
    sid    = "StreamInteractions"
    effect = "Allow"
    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator",
      "kinesis:GetRecords",
      "kinesis:ListShards"
    ]
    resources = [
      "arn:aws:firehose:${var.region}:${local.account_id}:deliverystream/${module.resource_names["delivery_stream"].standard}"
    ]
  }

  statement {
    sid    = "PassRole"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "arn:aws:firehose:${var.region}:${local.account_id}:role/${module.resource_names["consumer_role"].standard}"
    ]
  }
}
