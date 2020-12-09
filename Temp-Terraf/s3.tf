resource "aws_s3_bucket" "cf-templates-1vkgz6qfjdm0w-ca-central-1" {
    bucket = "cf-templates-1vkgz6qfjdm0w-ca-central-1"
    acl    = "private"
}

resource "aws_s3_bucket" "codepipeline-ca-central-1-69842399384" {
    bucket = "codepipeline-ca-central-1-69842399384"
    acl    = "private"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "SSEAndSSLPolicy",
  "Statement": [
    {
      "Sid": "DenyUnEncryptedObjectUploads",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::codepipeline-ca-central-1-69842399384/*",
      "Condition": {
        "StringNotEquals": {
          "s3:x-amz-server-side-encryption": "aws:kms"
        }
      }
    },
    {
      "Sid": "DenyInsecureConnections",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::codepipeline-ca-central-1-69842399384/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "springdb-bcp" {
    bucket = "springdb-bcp"
    acl    = "private"
    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailAclCheck20150319",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::springdb-bcp"
    },
    {
      "Sid": "AWSCloudTrailWrite20150319",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::springdb-bcp/SpringCS/AWSLogs/993185143381/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "webapp-springcs" {
    bucket = "webapp-springcs"
    acl    = "private"
    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Sid": "1",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E21T5LQYY6X8BG"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::webapp-springcs/*"
    }
  ]
}
POLICY
}

