cwlVersion: v1.2
class: CommandLineTool
baseCommand: falco
label: falco
doc: "A C++ implementation of FastQC for quality control of sequencing data.\n\nTool
  homepage: https://github.com/smithlabcode/falco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/falco:1.2.5--h077b44d_0
stdout: falco.out
