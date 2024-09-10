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

output "destination_arn" {
  value       = aws_cloudwatch_log_subscription_filter.log_subscription_filter.destination_arn
  description = "The ARN of the destination to deliver matching log events to"
}

output "distribution" {
  value       = aws_cloudwatch_log_subscription_filter.log_subscription_filter.distribution
  description = "The method used to distribute log data to the destination"
}

output "filter_pattern" {
  value       = aws_cloudwatch_log_subscription_filter.log_subscription_filter.filter_pattern
  description = "A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events"
}

output "id" {
  value       = aws_cloudwatch_log_subscription_filter.log_subscription_filter.id
  description = "The unique ID of the subscription filter"
}

output "log_group_name" {
  value       = aws_cloudwatch_log_subscription_filter.log_subscription_filter.log_group_name
  description = "The name of the log group to associate the subscription filter with"
}

output "name" {
  value       = aws_cloudwatch_log_subscription_filter.log_subscription_filter.name
  description = "A name for the subscription filter"
}

output "role_arn" {
  value       = aws_cloudwatch_log_subscription_filter.log_subscription_filter.role_arn
  description = "The ARN of an IAM role that grants CloudWatch Logs permissions to deliver ingested log events to the destination"
}
