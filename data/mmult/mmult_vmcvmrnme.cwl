cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmult_vmcvmrnme
label: mmult_vmcvmrnme
doc: "A tool for matrix multiplication (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/lijinbio/MMULT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmult:0.0.0.2--r40h8b68381_0
stdout: mmult_vmcvmrnme.out
