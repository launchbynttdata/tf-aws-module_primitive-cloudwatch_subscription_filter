## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#module\_cloudwatch\_log\_group) | ../.. | n/a |
| <a name="module_firehose_delivery_stream"></a> [firehose\_delivery\_stream](#module\_firehose\_delivery\_stream) | git::https://github.com/nexient-llc/tf-aws-module-firehose_delivery_stream | 0.1.0 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | git::https://github.com/nexient-llc/tf-aws-wrapper_module-s3_bucket | 0.1.1 |

## Resources

| Name | Type |
|------|------|
| [random_string.string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_subscription_filter"></a> [create\_subscription\_filter](#input\_create\_subscription\_filter) | Create a subscription filter tied to this Log Group | `bool` | `false` | no |
| <a name="input_length"></a> [length](#input\_length) | n/a | `number` | `24` | no |
| <a name="input_naming_prefix"></a> [naming\_prefix](#input\_naming\_prefix) | Prefix for the provisioned resources. | `string` | `"platform"` | no |
| <a name="input_number"></a> [number](#input\_number) | n/a | `bool` | `true` | no |
| <a name="input_special"></a> [special](#input\_special) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | n/a |
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.66.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |
| <a name="module_cloudwatch_log_subscription_filter"></a> [cloudwatch\_log\_subscription\_filter](#module\_cloudwatch\_log\_subscription\_filter) | ../.. | n/a |
| <a name="module_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#module\_cloudwatch\_log\_group) | git::https://github.com/launchbynttdata/tf-aws-module_primitive-cloudwatch_log_group | 1.0.1 |
| <a name="module_cloudwatch_log_stream"></a> [cloudwatch\_log\_stream](#module\_cloudwatch\_log\_stream) | git::https://github.com/launchbynttdata/tf-aws-module_primitive-cloudwatch_log_stream | 1.0.1 |
| <a name="module_firehose_delivery_stream"></a> [firehose\_delivery\_stream](#module\_firehose\_delivery\_stream) | git::https://github.com/launchbynttdata/tf-aws-module_primitive-firehose_delivery_stream | 1.1.0 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | git::https://github.com/launchbynttdata/tf-aws-module_collection-s3_bucket | 1.0.0 |
| <a name="module_producer_role"></a> [producer\_role](#module\_producer\_role) | git::https://github.com/launchbynttdata/tf-aws-module_collection-iam_assumable_role | 1.0.1 |
| <a name="module_consumer_role"></a> [consumer\_role](#module\_consumer\_role) | git::https://github.com/launchbynttdata/tf-aws-module_collection-iam_assumable_role | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.consumer_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.producer_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"backend"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"us-east-2"` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-module-resource\_name to generate resource names | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 60)<br>    }<br>  ))</pre> | <pre>{<br>  "consumer_policy": {<br>    "max_length": 60,<br>    "name": "cnsmr-plcy"<br>  },<br>  "consumer_role": {<br>    "max_length": 60,<br>    "name": "cnsmr-role"<br>  },<br>  "delivery_stream": {<br>    "max_length": 63,<br>    "name": "ds"<br>  },<br>  "log_group": {<br>    "max_length": 63,<br>    "name": "lg"<br>  },<br>  "log_stream": {<br>    "max_length": 63,<br>    "name": "ls"<br>  },<br>  "producer_policy": {<br>    "max_length": 63,<br>    "name": "prdcr-plcy"<br>  },<br>  "producer_role": {<br>    "max_length": 63,<br>    "name": "prdcr-role"<br>  },<br>  "subscription_filter": {<br>    "max_length": 63,<br>    "name": "sub-fltr"<br>  }<br>}</pre> | no |
| <a name="input_producer_external_id"></a> [producer\_external\_id](#input\_producer\_external\_id) | STS External ID used for the assumption policy when creating the producer role. | `list(string)` | `null` | no |
| <a name="input_producer_trusted_service"></a> [producer\_trusted\_service](#input\_producer\_trusted\_service) | Trusted service used for the assumption policy when creating the producer role. Defaults to the logs service for the current AWS region. | `string` | `null` | no |
| <a name="input_producer_policy_json"></a> [producer\_policy\_json](#input\_producer\_policy\_json) | Policy JSON containing rights for the producer role. If not specified, will build a producer policy for CloudWatch Logs. | `string` | `null` | no |
| <a name="input_consumer_trusted_services"></a> [consumer\_trusted\_services](#input\_consumer\_trusted\_services) | Trusted service used for the assumption policy when creating the consumer role. Defaults to the firehose service. | `string` | `null` | no |
| <a name="input_consumer_external_id"></a> [consumer\_external\_id](#input\_consumer\_external\_id) | STS External ID used for the assumption policy when creating the consumer role. Defaults to the current AWS account ID. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources created by the module. | `map(string)` | `{}` | no |
| <a name="input_http_endpoint_url"></a> [http\_endpoint\_url](#input\_http\_endpoint\_url) | URL to which the Delivery Stream should deliver its records. | `string` | n/a | yes |
| <a name="input_http_endpoint_name"></a> [http\_endpoint\_name](#input\_http\_endpoint\_name) | Friendly name for the HTTP endpoint associated with this Delivery Stream. | `string` | n/a | yes |
| <a name="input_s3_error_prefix"></a> [s3\_error\_prefix](#input\_s3\_error\_prefix) | Prefix to prepend to failed records being sent to S3. Ensure this value contains a trailing slash if set to anything other than an empty string. | `string` | `""` | no |
| <a name="input_subscription_filter_name"></a> [subscription\_filter\_name](#input\_subscription\_filter\_name) | Name of the subscription filter to attach to this Log Group. Required if create\_subscription\_filter is true. | `string` | `null` | no |
| <a name="input_subscription_filter_role_arn"></a> [subscription\_filter\_role\_arn](#input\_subscription\_filter\_role\_arn) | Role ARN to attach to the subscription filter. This role should have permissions to PutRecord and PutRecordBatch on the delivery stream. | `string` | `null` | no |
| <a name="input_subscription_filter_delivery_stream_arn"></a> [subscription\_filter\_delivery\_stream\_arn](#input\_subscription\_filter\_delivery\_stream\_arn) | ARN of the Delivery Stream used as a target for this Log Group's records. | `string` | `null` | no |
| <a name="input_subscription_filter_pattern"></a> [subscription\_filter\_pattern](#input\_subscription\_filter\_pattern) | Filter expression used to filter records coming out of the Log Group. The default (empty string) will send all log records. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
