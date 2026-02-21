cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_deepvariant
label: deepvariant_run_deepvariant
doc: "DeepVariant is an analysis pipeline that uses a deep neural network to call
  genetic variants from next-generation DNA sequencing data.\n\nTool homepage: https://github.com/google/deepvariant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepvariant:1.9.0--pyh697b589_0
stdout: deepvariant_run_deepvariant.out
