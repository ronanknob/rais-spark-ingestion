

resource "aws_s3_object" "refined_zone" {
    bucket = "${var.base_bucket_name}"
    acl    = "private"
    key    = "refined_zone/"
}