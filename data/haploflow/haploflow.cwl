cwlVersion: v1.2
class: CommandLineTool
baseCommand: haploflow
label: haploflow
doc: "Haploflow is a strain-aware assembler for viral haplotypes. (Note: The provided
  text contains system error messages regarding a container runtime failure and does
  not include the tool's help documentation or usage instructions.)\n\nTool homepage:
  https://github.com/hzi-bifo/Haploflow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haploflow:1.0--h9948957_5
stdout: haploflow.out
