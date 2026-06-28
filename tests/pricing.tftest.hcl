provider "aws" {
  region = "us-east-1"
}

run "standard_instance" {
  command = plan

  variables {
    instance_type = "m5.large"
  }

  assert {
    condition     = output.cpus == 2
    error_message = "expected m5.large to have 2 vCPUs"
  }

  assert {
    condition     = output.memory == 8
    error_message = "expected m5.large to have 8 GiB memory"
  }
}

run "nano_instance" {
  command = plan

  variables {
    instance_type = "t3.nano"
  }

  assert {
    condition     = output.cpus == 2
    error_message = "expected t3.nano to have 2 vCPUs"
  }

  assert {
    condition     = output.memory == 0.5
    error_message = "expected t3.nano to have 0.5 GiB memory"
  }
}
