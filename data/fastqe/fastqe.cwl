cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqe
label: fastqe
doc: "A tool for FASTQ quality control analysis (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/lonsbio/fastqe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqe:0.5.2--pyhdfd78af_0
stdout: fastqe.out
