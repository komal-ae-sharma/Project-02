terraform {

  required_providers {

    aws = {

      source = "hashicorp/aws"

      version = "~> 5.0"

    }

  }

}



provider "aws" {

  region = "ap-south-1"

}



resource "aws_s3_bucket" "website" {

  bucket = var.bucket_name



  tags = {

    Name = "Terraform Static Website"

    Environment = "Training"

    Project = "Project-02"

  }

}



resource "aws_s3_bucket_website_configuration" "website" {

  bucket = aws_s3_bucket.website.id



  index_document {

    suffix = "index.html"

  }

}


# Allow public access to the website bucket
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Allow visitors to read website files
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })

  depends_on = [
    aws_s3_bucket_public_access_block.website
  ]
}


resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
}