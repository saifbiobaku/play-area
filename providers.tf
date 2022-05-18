# Provider supervisor, agent-1 and agent-2 us-east-1
provider "aws" {
  profile = var.profile
  region  = var.aws_region
  alias   = "region-us-east-1"
}