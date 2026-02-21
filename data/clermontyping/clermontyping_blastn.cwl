cwlVersion: v1.2
class: CommandLineTool
baseCommand: clermontyping_blastn
label: clermontyping_blastn
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract a container image due to lack
  of disk space.\n\nTool homepage: https://github.com/happykhan/ClermonTyping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clermontyping:24.02--py312hdfd78af_1
stdout: clermontyping_blastn.out
