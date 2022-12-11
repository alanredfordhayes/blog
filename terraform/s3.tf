data "archive_file" "files" {
    for_each = toset(local.site_pages)
    type = local.archive_file__files__type
    source_dir  = format("$s/%s", path.module, [each.key])
    output_path = format("$s/%s.zip", path.module, [each.key])

}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = local.project_name
  force_destroy = true
}

