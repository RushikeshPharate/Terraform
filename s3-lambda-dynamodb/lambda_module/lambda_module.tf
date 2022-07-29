
variable "lambda_role_arn" {

}

variable "s3_bucket_id" {
  
}

variable "s3_bucket_arn" {
  
}

data "archive_file" "convert_to_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_code/main.py"
  output_path = "${path.module}/lambda_code/main.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "./${path.module}/lambda_code/main.zip"
  function_name = "post_to_db"
  role          = "${var.lambda_role_arn}"
  handler       = "main.post_to_db"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("./${path.module}/lambda_code/main.zip")

  runtime = "python3.8"

#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
}


resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "${s3_bucket_arn}"
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${s3_bucket_id}"

  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/"
    filter_suffix       = ".log"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
