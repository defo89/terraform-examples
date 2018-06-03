data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "source"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambda_ec2_shutdown" {
  filename         = "lambda.zip"
  function_name    = "stop_ec2_instances"
  role             = "${aws_iam_role.lambda_ec2_role.arn}"
  handler          = "lambda_ec2_stop.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.6"
}

resource "aws_lambda_permission" "lambda_permission_stop_ec2" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_ec2_shutdown.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.cw_ec2_shutdown.arn}"
}
