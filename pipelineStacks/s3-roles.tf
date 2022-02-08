resource "aws_s3_bucket" "example" {
  bucket = var.aritifact_bucket_name
  acl    = "private"
      provisioner "local-exec" {
    when    = destroy
    #command = "echo ${self.id} > testfile.txt"
    command = "aws s3 rm s3://rady-bucket-pipeline-artifacts --recursive"
  }
}

variable "aritifact_bucket_name" {
    description = "Please use your own bucket names"
    default = "rady-bucket-pipeline-artifacts"
}

