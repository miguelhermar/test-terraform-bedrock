```terraform
# Create an S3 bucket
resource "aws_s3_bucket" "source_bucket" {
  bucket = "my-source-bucket"
  acl    = "private"
}

# Define an IAM policy to allow any principal to get objects from the S3 bucket
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.source_bucket.arn}/*",
    ]
  }
}

# Attach the policy to the S3 bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.source_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}
```

This Terraform code creates an S3 bucket named "my-source-bucket" with private access control. It then defines an IAM policy document that allows any principal to perform the "s3:GetObject" action on objects within the bucket. Finally, it attaches this policy to the S3 bucket.

Note that this code assumes the default configurations for the S3 bucket, as per the provided requirements. If you need additional configurations like versioning, encryption, access logging, or cross-region replication, you can add them to the `aws_s3_bucket` resource block.