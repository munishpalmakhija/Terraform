provider "aws" {
 region = var.aws_region
 access_key = var.aws_access_key
 secret_key = var.aws_secret_key
}

data "aws_iam_role" "lambda_role" {
  name = var.aws_iam_lambda_role
}

data "aws_cloudwatch_log_group" "cloudwatch_loggroup" {
  name = var.aws_cloudwatch_log_group
}

resource "aws_lambda_function" "vrli_cloud_lambda-cloudwatchlogs" {
  filename      = "./Lambda.zip"
  function_name = "vrli_cloud_lambda-cloudwatchlogs"
  role          = data.aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs12.x"

  environment {
    variables = {
    LogIntelligence_API_Token = var.vrlicloud_apikey
    LogIntelligence_API_Url = var.vrlicloud_url
    }
  }
}


resource "aws_lambda_permission" "vrli_cloud_lambda_cloudwatch_permission" {
  statement_id  = "AllowCloudWatchInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.vrli_cloud_lambda-cloudwatchlogs.arn
  principal = "logs.us-west-2.amazonaws.com"
  source_arn = data.aws_cloudwatch_log_group.cloudwatch_loggroup.arn
}


resource "aws_cloudwatch_log_subscription_filter" "vrlicloud-cloudwatch-lambda-subscription" {
  depends_on      = [aws_lambda_permission.vrli_cloud_lambda_cloudwatch_permission]
  name            = "cloudwatch-vrlicloud-lambda-subscription"
  log_group_name  = data.aws_cloudwatch_log_group.cloudwatch_loggroup.name
  filter_pattern  = var.aws_cloudwatch_log_filter
  destination_arn = aws_lambda_function.vrli_cloud_lambda-cloudwatchlogs.arn
}