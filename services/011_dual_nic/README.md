# Basic EC2 instance

Configuration in this directory creates EC2 instances with two network interfaces for ProdMan, DevMan, and QAMan.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan -var-file=(EnvFile)
$ terraform apply -var-file=(EnvFile)
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 2.65 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.65 |
