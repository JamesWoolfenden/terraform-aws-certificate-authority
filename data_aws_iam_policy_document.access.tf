data "aws_iam_policy_document" "access" {
  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      aws_s3_bucket.crl.arn,
      "${aws_s3_bucket.crl.arn}/*"
    ]

    condition {
      test     = "StringLike"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:acm-pca:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:certificate-authority*"]
    }

    principals {
      type        = "Service"
      identifiers = ["acm-pca.amazonaws.com"]
    }
  }

  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.crl.arn,
      "${aws_s3_bucket.crl.arn}/*"
    ]

    principals {
      type = "*"
      identifiers = ["*"]
    }
  }

  statement {
    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.crl.arn,
      "${aws_s3_bucket.crl.arn}/*"
    ]

    principals {
      type = "AWS"
      identifiers = ["${data.aws_caller_identity.current.arn}"]
    }
  }
}
