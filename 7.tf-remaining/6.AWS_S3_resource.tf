resource "aws_s3_bucket" "media_static_bucket" {
    bucket = "media-static-bucket-23edft67ujio"
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