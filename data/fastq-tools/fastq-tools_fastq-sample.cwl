cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq-sample
label: fastq-tools_fastq-sample
doc: "A tool from the fastq-tools suite. Note: The provided help text contains system
  error messages and does not list usage or arguments.\n\nTool homepage: http://homes.cs.washington.edu/~dcjones/fastq-tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-tools:0.8.3--h38613fd_1
stdout: fastq-tools_fastq-sample.out
