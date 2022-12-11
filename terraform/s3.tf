data "archive_file" "files" {
    for_each = toset(local.site_pages)
    type = local.archive_file__files__type
    source_dir  = "${path.module}/terraform/${each.key}"
    output_path = "${path.module}/terraform/${each.key}.zip"

}

resource "aws_s3_bucket" "bucket" {
    bucket_prefix = local.project_name
    force_destroy = true
}

