cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-sort
label: fastq-tools_fastq-sort
doc: "Sort FASTQ files (Note: The provided help text contained only container execution
  errors and no usage information. No arguments could be extracted.)\n\nTool homepage:
  http://homes.cs.washington.edu/~dcjones/fastq-tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-tools:0.8.3--h38613fd_1
stdout: fastq-tools_fastq-sort.out
