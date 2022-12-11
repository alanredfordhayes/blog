data "archive_file" "files" {
    type = local.archive_file__files__type

    dynamic "settings" {
        for_each = toset(local.site_pages)
        content{
            source_dir  = format("${path.module}/%s", settings.value)
            output_path = format("${path.module}/%s.zip", settings.value)
        }

      
    }
}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = local.project_name
  force_destroy = true
}

