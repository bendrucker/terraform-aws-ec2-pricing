output "cpus" {
  value = parseint(local.attributes.vcpu, 10)
  description = "Number of CPU cores available on the instance"
}

output "memory" {
  value = tonumber(regex("((0.)?\\d+) GiB", local.attributes.memory)[0])
  description = "Memory available on the instance, in gibibytes (GiB)"
}
