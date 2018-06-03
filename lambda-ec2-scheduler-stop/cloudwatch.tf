resource "aws_cloudwatch_event_rule" "cw_ec2_shutdown" {
  name        = "shutdown-ec2"
  description = "Power off EC2 instances at the end of the day"

  schedule_expression = "cron(0 14 ? * MON-SUN *)"
}

resource "aws_cloudwatch_event_target" "cw_lambda_ec2_shutdown" {
  target_id = "${aws_lambda_function.lambda_ec2_shutdown.handler}"
  rule      = "${aws_cloudwatch_event_rule.cw_ec2_shutdown.name}"
  arn       = "${aws_lambda_function.lambda_ec2_shutdown.arn}"
}
