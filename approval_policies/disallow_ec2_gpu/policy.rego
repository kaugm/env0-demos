package env0.deployment

default allow = false

cloud_approvers := "33e6406c-2be2-431e-b6d2-fcb3cce2d447" # CloudOps Approvers team

# METADATA
# title: require approval on GPU instance present
# description: require approval from cloud_approvers if cost estimation is returning any value greater than $15/month on the plan
pending[message] {
  resource := input.plan.resource_changes[_]
  resource.type == "aws_instance"
  instance_type := resource.change.after.instance_type
  is_gpu_instance(instance_type)
  not any_approver_present
  message := sprintf("SECURITY RULE 2: Require approval from CloudOps Admins Team if GPU-based instance is present in plan. GPU instance type '%s' is not allowed", [instance_type])
}

# Helper function to detect GPU instance types
is_gpu_instance(instance_type) {
  lowered := lower(instance_type)
  startswith(lowered, "p")
} {
  lowered := lower(instance_type)
  startswith(lowered, "g")
} {
  lowered := lower(instance_type)
  startswith(lowered, "inf")
} {
  lowered := lower(instance_type)
  startswith(lowered, "trn")
} {
  lowered := lower(instance_type)
  startswith(lowered, "vt")
}


# METADATA
# title: allow if approved by anyone from cost_approveres team
# description: deployment can be approved by someone from cost_approvers team (id)
allow[format(rego.metadata.rule())] {
  any_approver_present
  not deny[_]
}

any_approver_present {
  input.approvers[_].teams[_].id == cloud_approvers
}