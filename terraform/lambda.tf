resource "aws_lambda_function" "lambdas" {
    for_each = aws_s3_object.objects

    function_name = "${local.project_name}-${each.value.tags.site}"
    description = "${local.project_name}-${each.value.tags.site}"
    publish = true

    s3_bucket = aws_s3_bucket.bucket.id
    s3_key    = each.value.tags.s3_key
    source_code_hash = data.archive_file.files[each.value.tags.site].output_base64sha256
    
    runtime = local.aws_lambda_function__lambdas__runtime
    handler = local.aws_lambda_function__lambdas__handler

    role = aws_iam_role.roles[each.value.tags.key].arn
}