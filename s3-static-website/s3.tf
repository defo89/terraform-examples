resource "aws_s3_bucket" "bucket_web" {
  bucket = "${var.s3_bucket_name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  force_destroy = true

  website {
    index_document = "${var.index_file}"
    error_document = "${var.error_file}"
  }
}

resource "aws_s3_bucket_object" "object_index" {
  bucket       = "${aws_s3_bucket.bucket_web.id}"
  key          = "${var.index_file}"
  source       = "${var.index_file}"
  content_type = "text/html"
  acl          = "public-read"
  etag         = "${md5(file("${var.index_file}"))}"
}

resource "aws_s3_bucket_object" "object_error" {
  bucket       = "${aws_s3_bucket.bucket_web.id}"
  key          = "${var.error_file}"
  source       = "${var.error_file}"
  content_type = "text/html"
  acl          = "public-read"
  etag         = "${md5(file("${var.error_file}"))}"
}
