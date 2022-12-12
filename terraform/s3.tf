data "archive_file" "files" {
    for_each = toset(local.site_pages)
    type = local.archive_file__files__type
    source_dir  = "${path.module}/${each.key}"
    output_path = "${path.module}/${each.key}.zip"
}

resource "aws_s3_bucket" "bucket" {
    bucket_prefix = local.project_name
    force_destroy = true
}

resource "aws_s3_object" "objects" {
    for_each = data.archive_file.files
    bucket = aws_s3_bucket.bucket.id

    key    = each.value.output_path
    source = each.value.output_path
    etag = filemd5(each.value.output_path)
    tags = {
        source_dir = "${each.value.source_dir}",
        output_path = "${each.value.output_path}"
    }
}