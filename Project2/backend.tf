#stores terraform state file in s3 bucket.
terraform {
    backend "s3" {
        bucket = 
        key = 
        region = 
        profile = 
    }
}