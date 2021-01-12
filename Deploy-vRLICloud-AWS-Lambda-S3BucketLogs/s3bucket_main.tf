provider "aws" {
 region = var.aws_region
 access_key = var.aws_access_key
 secret_key = var.aws_secret_key 
}

data "aws_s3_bucket" "bucket" {
  bucket = var.aws_s3_bucket
}

data "aws_iam_role" "lambda_role" {
  name = var.aws_iam_lambda_role
}

resource "aws_lambda_function" "vrli_cloud_lambda-s3bucketlogs" {
  filename      = "./Lambda.zip"
  function_name = "vrli_cloud_lambda-s3bucketlogs"
  role          = data.aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs12.x"

  environment {
    variables = {
    LogIntelligence_API_Token = var.vrlicloud_apikey
    LogIntelligence_API_Url = var.vrlicloud_url
    S3Bucket_Logs = "true"
    }
  }
}

resource "aws_lambda_permission" "vrli_cloud_lambda_permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.vrli_cloud_lambda-s3bucketlogs.arn
  principal = "s3.amazonaws.com"
  source_arn = data.aws_s3_bucket.bucket.arn
}

resource "aws_s3_bucket_notification" "vrli_cloud_lambda_s3trigger" {
    bucket = data.aws_s3_bucket.bucket.id
    lambda_function {
        lambda_function_arn = aws_lambda_function.vrli_cloud_lambda-s3bucketlogs.arn
        events              = ["s3:ObjectCreated:*"]     
    }
    depends_on = [aws_lambda_permission.vrli_cloud_lambda_permission]
}
