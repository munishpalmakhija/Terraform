# aws access key
variable "aws_access_key" {}

# aws secret key
variable "aws_secret_key" {}

# aws region
variable "aws_region" {}

# aws iam role for lambda
variable "aws_iam_lambda_role" {}

# aws cloudwatch log group
variable "aws_cloudwatch_log_group" {}

# aws cloudwatch log group filter
variable "aws_cloudwatch_log_filter" {
    default = ""
}

# vrli cloud url
variable "vrlicloud_url" {
    default = "https://data.mgmt.cloud.vmware.com/le-mans/v1/streams/ingestion-pipeline-stream"
}

# vrli cloud api key
variable "vrlicloud_apikey" {}