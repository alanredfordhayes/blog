data "archive_file" "files" {
    for_each = toset(local.site_pages)
    type = local.archive_file__files__type
    source_dir  = join(["${path.module}/", [each.key]])
    output_path  = join(["${path.module}/", [each.key], ".zip"])

}

resource "aws_s3_bucket" "bucket" {
    bucket_prefix = local.project_name
    force_destroy = true
}

