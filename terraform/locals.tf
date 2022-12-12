resource "random_string" "random" {
  length           = 8
  special          = false
  min_lower        = 8
}

locals {
    #site_pages
    site_pages = ["index", "register", "login", "logout", "dashboard"]

    #aws_api_gateway_rest_api
    project_name = "alanredfordhayes-${random_string.random.result}" 
    aws_api_gateway_rest_api__api_1__name = "${local.project_name}__api_1"
    aws_api_gateway_rest_api__api_1__endpoint_configuration = ["REGIONAL"]

    #aws_api_gateway_method
    aws_api_gateway_method__post__authorization = "NONE"
    aws_api_gateway_method__post__http_method = "POST"

    #aws_lambda_function
    aws_lambda_function__lambdas__function_name = toset(formatlist("project_name_%s", local.site_pages))

    #archive_file
    archive_file__files__type = "zip"

    #aws_lambda_function
    aws_lambda_function__lambdas__runtime = "python3.9"
    aws_lambda_function__lambdas__handler = "lambda_function.lambda_handler"

    aws_iam_role__roles__asume_role_policy = jsonencode(
        {
            Version = "2012-10-17"
            Statement = [
                {
                    Action = "sts:AssumeRole"
                    Effect = "Allow"
                    Sid    = ""
                    Principal = {
                        Service = "lambda.amazonaws.com"
                    }
                }
            ]
        }
    )

    aws_iam_role_policy_attachment__policy_attachments__policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    aws_iam_policy_path = "/"
    aws_iam_policy__policies__policy = jsonencode(
        {
          Version = "2012-10-17"
          Statement = [
            {
              Effect = "Allow"
              Action = [
              "logs:CreateLogStream",
              "logs:PutLogEvents",
              "logs:CreateLogGroup"
              ],
              Resource = "*"
            }
          ]
        }
    )
}