# Variables block
variable "aws_access_key" {}
variable "aws_secret_key" {}

# Builders block
builder "amazon-ebs" {
  type          = "amazon-ebs"
  region        = "your-aws-region"
  instance_type = "m4.4xlarge"  # Updated to m4.4xlarge

  source_ami_filter {
    filters = {
      name              = "Windows_Server-2022-English-Full-Base-*"
      virtualization-type = "hvm"
      architecture      = "x86_64"
    }
    owners      = ["amazon"]
    most_recent = true
  }

  ami_name           = "Windows-Server-2022-with-GitLab-Runner {{timestamp}}"
  user_data          = file("./user-data.ps1")
  ssh_username       = "Administrator"

  ami_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 100
    volume_type = "gp3"
  }

  ami_description = "Windows Server 2022 with GitLab Runner"
}

# Provisioners block
provisioner "shell" {
  type    = "powershell"
  script  = "./install-gitlab-runner.ps1"
}

# Post-processors block
post-processor "manifest" {
  output = "manifest.json"
}

post-processor "amazon-import" {
  type        = "amazon-import"
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
  region      = "your-aws-region"
  source_ami  = "${build.name}"
}
