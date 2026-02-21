cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-and-furious
label: fastq-and-furious
doc: "A tool for fast processing of FASTQ files (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/lgautier/fastq-and-furious"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-and-furious:0.3.2--py312hf67a6ed_4
stdout: fastq-and-furious.out
