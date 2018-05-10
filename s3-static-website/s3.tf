resource "aws_s3_bucket" "bucket_web" {
  bucket = "my-test-s3-website-2018-05"
  acl    = "public-read"

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
  bucket = "${aws_s3_bucket.bucket_web.id}"
  key    = "index.html"
  source = "files/index.html"
}

resource "aws_s3_bucket_object" "object_error" {
  bucket = "${aws_s3_bucket.bucket_web.id}"
  key    = "error.html"
  source = "files/error.html"
}
