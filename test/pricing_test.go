package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestStandardInstance(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"instance_type": "m5.large",
		},
	}

	terraform.InitAndApply(t, options)

	assert.Equal(t, "2", terraform.Output(t, options, "cpus"))
	assert.Equal(t, "8", terraform.Output(t, options, "memory"))
}

func TestNanoInstance(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"instance_type": "t3.nano",
		},
	}

	terraform.InitAndApply(t, options)

	assert.Equal(t, "2", terraform.Output(t, options, "cpus"))
	assert.Equal(t, "0.5", terraform.Output(t, options, "memory"))
}
