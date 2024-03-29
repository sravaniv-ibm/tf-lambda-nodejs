provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "example" {
  function_name = "ServerlessExample"

  # The bucket name as created earlier with "aws s3api create-bucket"
  #s3_bucket = "sf-terraform-serverless"
  #s3_key    = "v1.0.0/lambda-function.zip"

  #Fetch the Zip File present in Local Folder
  filename         = "C:/Users/VenkataSatyaSravaniM/Desktop/StateFarm-Account/Terraform/lambda-function/lambda-event-function.zip"
  source_code_hash = "${filebase64sha256("C:/Users/VenkataSatyaSravaniM/Desktop/StateFarm-Account/Terraform/lambda-function/lambda-event-function.zip")}"

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  #handler = "main.handler"
  handler = "index.handler"
  runtime = "nodejs10.x"

  role = "${aws_iam_role.lambda_exec.arn}"
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
