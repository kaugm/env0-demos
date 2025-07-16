package env0.deployment

deny[reason] {
  resource := input.plan.resource_changes[_]
  resource.type == "aws_instance"
  instance_type := resource.change.after.instance_type
  is_gpu_instance(instance_type)

  reason := sprintf("GPU instance type '%s' is not allowed", [instance_type])
}

is_gpu_instance(instance_type) {
  # Lowercase for consistent match
  lowered := lower(instance_type)
  startswith(lowered, "p")  # e.g., p2, p3, p4
} {
  lowered := lower(instance_type)
  startswith(lowered, "g")  # e.g., g4, g5
} {
  lowered := lower(instance_type)
  startswith(lowered, "inf")  # Inferentia
} {
  lowered := lower(instance_type)
  startswith(lowered, "trn")  # Trainium
} {
  lowered := lower(instance_type)
  startswith(lowered, "vt")  # VT1
}