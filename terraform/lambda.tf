resource "aws_lambda_function" "lambdas" {
    for_each = aws_s3_object.objects

    function_name = "${local.project_name}/${each.value.key}"
    description = "${local.project_name}/${each.value.key}"

    s3_bucket = aws_s3_bucket.bucket.id
    s3_key    = each.value.key
    source_code_hash = data.archive_file.files.output_base64sha256
    
    runtime = local.aws_lambda_function__lambdas__runtime
    handler = local.aws_lambda_function__lambdas__handler

    role = aws_iam_role.roles.arn
}