resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.crl.id
  policy = data.aws_iam_policy_document.access.json
}
