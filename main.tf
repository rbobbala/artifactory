provider "aws" {
  #    assume_role {  #   role_arn     = "arn:aws:iam::881670337532:role/environment"  #  session_name = "EC2"  # external_id  = "111"  #    }

  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
   region     = "us-east-1"
  profile    = "default"
}

resource "aws_s3_bucket" "Artefactory" {
  bucket = "artifactorypoc"
  acl    = "public-read"

  provisioner "local-exec" {
    command = "echo ${aws_s3_bucket.Artefactory.arn} >> arn"
   # command = "echo ${aws_s3_bucket.poc.id} >> id"
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "Artefactory" {
  bucket = "${aws_s3_bucket.Artefactory.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1566380613035",
    "Statement": [
        {
            "Sid": "Stmt1566380610508",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::artifactorypoc/*"
        }
    ]
}
POLICY
}
