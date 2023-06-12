# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "domain_name" {
  description = "Public domain name of EC2 instance"
  value       = aws_instance.web.public_dns
}
