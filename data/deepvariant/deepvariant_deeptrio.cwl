cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepvariant_deeptrio
label: deepvariant_deeptrio
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build a container image due to lack
  of disk space.\n\nTool homepage: https://github.com/google/deepvariant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepvariant:1.9.0--pyh697b589_0
stdout: deepvariant_deeptrio.out
