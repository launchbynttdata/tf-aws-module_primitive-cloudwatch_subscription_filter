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

variable "cloudwatch_log_group_name" {
  description = "Name of the log group."
  type        = string
}

variable "subscription_filter_name" {
  description = "Name of the subscription filter to attach to this Log Group. Required if create_subscription_filter is true."
  type        = string
  default     = null
}

variable "subscription_filter_role_arn" {
  type        = string
  default     = null
  description = "Role ARN to attach to the subscription filter. This role should have permissions to PutRecord and PutRecordBatch on the delivery stream."
}

variable "subscription_filter_delivery_stream_arn" {
  type        = string
  default     = null
  description = "ARN of the Delivery Stream used as a target for this Log Group's records."
}

variable "subscription_filter_pattern" {
  type        = string
  default     = ""
  description = "Filter expression used to filter records coming out of the Log Group. The default (empty string) will send all log records."
}
