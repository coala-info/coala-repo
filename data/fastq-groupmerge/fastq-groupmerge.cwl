cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-groupmerge
label: fastq-groupmerge
doc: "A tool for merging groups of FASTQ files (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/SantaMcCloud/fastq-groupmerge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-groupmerge:1.0.2--pyhdfd78af_0
stdout: fastq-groupmerge.out
