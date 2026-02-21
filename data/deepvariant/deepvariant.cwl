cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepvariant
label: deepvariant
doc: "DeepVariant is a deep learning-based variant caller. (Note: The provided help
  text contains only system logs and error messages regarding a container build failure
  and does not list command-line arguments.)\n\nTool homepage: https://github.com/google/deepvariant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepvariant:1.9.0--pyh697b589_0
stdout: deepvariant.out
