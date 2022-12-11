data "archive_file" "files" {
    for_each = toset(local.site_pages)
    type = local.archive_file__files__type
    source_dir  = format("${path.module}/%s", [each.value])
    output_path = format("${path.module}/%s.zip", [each.value])

}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = local.project_name
  force_destroy = true
}

