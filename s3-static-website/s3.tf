resource "aws_s3_bucket" "bucket_web" {
  bucket = "my-test-s3-website-2018-05"
  acl    = "private"

  versioning {
    enabled = true
  }

  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
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
