cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-stats
label: fastq-tools_fastq-stats
doc: "A tool to calculate statistics for FASTQ files. (Note: The provided help text
  contained only system error messages and no usage information.)\n\nTool homepage:
  http://homes.cs.washington.edu/~dcjones/fastq-tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-tools:0.8.3--h38613fd_1
stdout: fastq-tools_fastq-stats.out
