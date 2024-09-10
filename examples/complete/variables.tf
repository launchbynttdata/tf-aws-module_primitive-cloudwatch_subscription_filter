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

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false
  default     = "launch"

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false
  default     = "backend"

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }
}

variable "environment" {
  description = "Environment in which the resource should be provisioned like dev, qa, prod etc."
  type        = string
  default     = "dev"
}

variable "environment_number" {
  description = "The environment count for the respective environment. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

variable "resource_number" {
  description = "The resource count for the respective resource. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

variable "region" {
  description = "AWS Region in which the infra needs to be provisioned"
  type        = string
  default     = "us-east-2"
}

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-module-resource_name to generate resource names"
  type = map(object(
    {
      name       = string
      max_length = optional(number, 60)
    }
  ))
  default = {
    log_group = {
      name       = "lg"
      max_length = 63
    }
    log_stream = {
      name       = "ls"
      max_length = 63
    }
    subscription_filter = {
      name       = "subfltr"
      max_length = 63
    }
    delivery_stream = {
      name       = "ds"
      max_length = 63
    }
    producer_role = {
      name       = "prdcrrole"
      max_length = 63
    }
    producer_policy = {
      name       = "prdcrplcy"
      max_length = 63
    }
    consumer_policy = {
      name       = "cnsmrplcy"
      max_length = 60
    }
    consumer_role = {
      name       = "cnsmrrole"
      max_length = 60
    }
  }
}

variable "producer_external_id" {
  description = "STS External ID used for the assumption policy when creating the producer role."
  type        = list(string)
  default     = null
}

variable "producer_trusted_service" {
  description = "Trusted service used for the assumption policy when creating the producer role. Defaults to the logs service for the current AWS region."
  type        = string
  default     = null
}

variable "consumer_trusted_services" {
  description = "Trusted service used for the assumption policy when creating the consumer role. Defaults to the firehose service."
  type        = string
  default     = null
}

variable "consumer_external_id" {
  description = "STS External ID used for the assumption policy when creating the consumer role. Defaults to the current AWS account ID."
  type        = string
  default     = null
}

variable "http_endpoint_url" {
  description = "URL to which the Delivery Stream should deliver its records."
  type        = string
}

variable "http_endpoint_name" {
  description = "Friendly name for the HTTP endpoint associated with this Delivery Stream."
  type        = string
}

variable "s3_error_prefix" {
  description = "Prefix to prepend to failed records being sent to S3. Ensure this value contains a trailing slash if set to anything other than an empty string."
  type        = string
  default     = ""
}
