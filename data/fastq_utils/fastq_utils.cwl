cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_utils
label: fastq_utils
doc: "A collection of utilities for processing FASTQ files.\n\nTool homepage: https://github.com/nunofonseca/fastq_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq_utils:0.25.3--ha9dfd29_0
stdout: fastq_utils.out
