#Create DynamoDB
resource "aws_dynamodb_table" "dynamodb_table" {
  name             = var.DynamoDB_name
  hash_key         = "HashKey"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "HashKey"
    type = "S"
  }

}

#Create VPC Endpoint for DynamoDB
resource "aws_vpc_endpoint" "dynamodb_Endpoint" {
    vpc_id              = aws_vpc.vpc.id
    service_name        = "com.amazonaws.${var.region}.dynamodb"
    vpc_endpoint_type   = "Gateway"
    route_table_ids     = [aws_route_table.private.id]
    policy              = jsonencode({
        "Version"       : "2012-10-17",
        "Statement"     : [
            {
                "Effect"    : "Allow",
                "Principal" : "*",
                "Action"    : "*",
                "Resource"  : "*"
            }
        ]
    })
}