resource "aws_s3_object" "refined_zone" {
    bucket = "${var.base_bucket_name}"
    acl    = "private"
    key    = "refined_zone/"
}

resource "aws_s3_object" "codigo_processamento_rais" {
    bucket = "${var.base_bucket_name}"
    key = "emr-code/job_spark.py"
    acl = "private"
    source = "../emr-jobs/process_rais.py"
    etag = filemd5( "../emr-jobs/process_rais.py")
}