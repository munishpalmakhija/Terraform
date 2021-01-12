# aws access key
variable "aws_access_key" {}

# aws secret key
variable "aws_secret_key" {}

# aws region
variable "aws_region" {}

# aws s3 bucket
variable "aws_s3_bucket" {}

# aws iam role for lambda
variable "aws_iam_lambda_role" {}

# vrli cloud url
variable "vrlicloud_url" {
    default = "https://data.mgmt.cloud.vmware.com/le-mans/v1/streams/ingestion-pipeline-stream"
}

# vrli cloud api key
variable "vrlicloud_apikey" {}