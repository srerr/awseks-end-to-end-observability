resource "aws_s3_bucket" "media_static_bucket" {
    bucket = "media-static-bucket-23edft67ujiosreeram"
    force_destroy = true
    tags = {
        Name = "media-static-bucket"
    }
  
}
resource "aws_s3_bucket_object" "media_folder" {
    bucket = aws_s3_bucket.media_static_bucket.bucket
    key    = "media/"
}
resource "aws_s3_bucket_object" "static_folder" {
    bucket = aws_s3_bucket.media_static_bucket.bucket
    key    = "static/"
}
resource "aws_s3_bucket_public_access_block" "media_static_bucket_public_access" {
    bucket = aws_s3_bucket.media_static_bucket.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "media_static_bucket_policy" {
    bucket = aws_s3_bucket.media_static_bucket.id
    depends_on = [ aws_s3_bucket_public_access_block.media_static_bucket_public_access ]
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid       = "PublicReadGetObject"
                Effect    = "Allow"
                Principal = "*"
                Action    = "s3:GetObject"
                Resource  = "${aws_s3_bucket.media_static_bucket.arn}/static/*"
            },
            {
                Sid       = "PublicReadGetObject"
                Effect    = "Allow"
                Principal = "*"
                Action    = "s3:GetObject"
                Resource  = "${aws_s3_bucket.media_static_bucket.arn}/media/*"
            }
        ]
    })
}