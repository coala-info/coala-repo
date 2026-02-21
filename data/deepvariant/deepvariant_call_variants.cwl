cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - call_variants
label: deepvariant_call_variants
doc: "The provided text does not contain help information or argument descriptions;
  it appears to be a system error log related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/google/deepvariant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepvariant:1.9.0--pyh697b589_0
stdout: deepvariant_call_variants.out
