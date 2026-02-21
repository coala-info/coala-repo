cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq_utils
  - fastq_filter_n
label: fastq_utils_fastq_filter_n
doc: "A tool to filter FASTQ sequences based on N content. (Note: The provided input
  text contains system error messages rather than the tool's help documentation, so
  no arguments could be extracted.)\n\nTool homepage: https://github.com/nunofonseca/fastq_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq_utils:0.25.3--ha9dfd29_0
stdout: fastq_utils_fastq_filter_n.out
