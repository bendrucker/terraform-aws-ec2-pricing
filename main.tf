locals {
  attributes = jsondecode(data.aws_pricing_product.selected.result).product.attributes
}

data "aws_pricing_product" "selected" {
  service_code = "AmazonEC2"

  filters {
    field = "instanceType"
    value = var.instance_type
  }

  filters {
    field = "operatingSystem"
    value = "Linux"
  }

  filters {
    field = "location"
    value = "US East (N. Virginia)"
  }

  filters {
    field = "preInstalledSw"
    value = "NA"
  }

  filters {
    field = "licenseModel"
    value = "No License required"
  }

  filters {
    field = "tenancy"
    value = "Shared"
  }

  filters {
    field = "capacitystatus"
    value = "Used"
  }
}
