terraform {
  backend "s3" {
    bucket         = "<your_s3_bucket_name>"  # Nombre del bucket de S3
    key            = "App/simple-app1"             # Ruta dentro del bucket
    region         = "eu-west-1"              # Región de AWS
  }
}