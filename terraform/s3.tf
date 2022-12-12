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
        output_path = "${each.value.output_path}",
        site = trimprefix("${each.value.source_dir}", "./")
        key = "${each.key}"
        s3_key = trimprefix("${each.value.output_path}", "./")
    }
}

resource "aws_s3_bucket" "site" {
    bucket_prefix = local.aws_s3_bucket__site__bucket_prefix
    force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "site" {
    bucket = aws_s3_bucket.site.bucket

    index_document {
        suffix = "index.html"
    }
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = local.aws_iam_policy__site__policy
}

resource "aws_s3_object" "site" {
    for_each = fileset(path.module, "site/*")
    bucket = aws_s3_bucket.site.id
    key    = each.key
    source = each.key
}