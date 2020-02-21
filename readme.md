# terraform-aws-ec2-pricing

> Example of using the [AWS Pricing API](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/price-changes.html) to query EC2 instance type attributes

## Usage

```tf
module "instance" {
  source        = "bendrucker/ec2-pricing/aws"
  instance_type = "m5.large"
}
```

The module exposes outputs that describe key attributes of the specified instance type. These values are helpful for creating monitoring or resource quotas that are defined relative to the instance's capacity.

For example, you might pass these along to a [`kubernetes_resource_quota`](https://www.terraform.io/docs/providers/kubernetes/r/resource_quota.html) in order to assign a percentage of cluster capacity to a namespace:

```tf
locals {
  # allow developers to use 80% of worker resources
  # reserve the remaining 20% for system components
  developer_quota = 0.8
}
resource "kubernetes_resource_quota" "developers" {
  metadata {
    name      = "developers-quota"
    namespace = "developers"
  }

  spec {
    hard = {
      cpu    = var.worker_count * module.instance.cpus * local.developer_quota
      memory = "${var.worker_count * module.instance.memory * local.developer_quota} GiB"
    }
  }
}
```

<!-- https://github.com/segmentio/terraform-docs -->
<!-- terraform-docs markdown table . -->

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| instance\_type | EC2 instance type for which attributes will be fetched | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cpus | Number of CPU cores available on the instance |
| memory | Memory available on the instance, in gibibytes (GiB) |

<!-- end terraform-docs -->

## Testing

This module is tested via [Terratest](https://github.com/gruntwork-io/terratest).

```sh
make test
```

## License

MIT © [Ben Drucker](http://bendrucker.me)
