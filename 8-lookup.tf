# Example: Using lookup() function in Terraform

locals {
  # Define a map of instance types by environment
  instance_types = {
    dev  = "t2.micro"
    prod = "t3.micro"
    test = "t2.small"
  }

  # Use lookup to pick instance type dynamically
  selected_instance_type = lookup(local.instance_types, "prod", "t2.nano")
}

output "lookup_example" {
  description = "The instance type chosen using lookup()"
  value       = local.selected_instance_type
}


# Example using a data source with lookup()
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

locals {
  ami_details = {
    id      = data.aws_ami.amazon_linux.id
    name    = data.aws_ami.amazon_linux.name
    owner   = data.aws_ami.amazon_linux.owner_id
  }

  ami_id_lookup = lookup(local.ami_details, "id", "no-ami-found")
}

output "ami_lookup_result" {
  value = local.ami_id_lookup
}
