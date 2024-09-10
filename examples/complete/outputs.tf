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

output "cloudwatch_log_group_name" {
  value       = module.cloudwatch_log_group.log_group_name
  description = "The name of the log group"
}

output "cloudwatch_log_subscription_filter_name" {
  value       = module.cloudwatch_log_subscription_filter.name
  description = "A name for the subscription filter"
}

output "cloudwatch_log_subscription_filter_destination_arn" {
  value       = module.cloudwatch_log_subscription_filter.destination_arn
  description = "The ARN of the destination to deliver matching log events to"
}

output "firehose_delivery_stream_arn" {
  value       = module.firehose_delivery_stream.arn
  description = "The ARN of the Kinesis Data Firehose delivery stream"
}
