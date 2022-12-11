# resource "aws_lambda_function" "lambdas" {  
#   function_name = local.aws_lambda_function__lambdas__function_name
#   description = local.aws_lambda_function__lambdas__function_name
#   s3_bucket = aws_s3_bucket.bucket.id
#   s3_key    = aws_s3_object.event_api.key
#   runtime = local.aws_lambda_function_runtime
#   handler = local.aws_lambda_function_event_api_handler
#   source_code_hash = data.archive_file.event_api.output_base64sha256
#   layers = [aws_lambda_layer_version.slack_bolt.arn, aws_lambda_layer_version.jira.arn]
#   role = aws_iam_role.event_api.arn
#   memory_size = local.aws_lambda_function_memory_size
#   publish = true
#   environment {
#     variables ={
#       event_api_table = local.aws_lambda_function_event_api_env_event_api_table
#       SLACK_BOT_TOKEN = var.SLACK_BOT_TOKEN
#       SLACK_SIGNING_SECRET = var.SLACK_SIGNING_SECRET
#       jira_admin_email = var.jira_admin_email
#       jira_admin_api_token = var.jira_admin_api_token
#     }
#   }
# }