package env0.deployment

default allow = false

# Allow if no GPU instances are found
allow {
  not deny[_]
}

# Deny if a GPU instance type is used
deny[reason] {
  resource := input.plan.resource_changes[_]
  resource.type == "aws_instance"
  instance_type := resource.change.after.instance_type
  is_gpu_instance(instance_type)

  reason := sprintf("GPU instance type '%s' is not allowed", [instance_type])
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
