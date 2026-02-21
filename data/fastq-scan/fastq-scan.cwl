cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-scan
label: fastq-scan
doc: "The provided text is an error log indicating a failure to pull the container
  image and does not contain the tool's help documentation. fastq-scan is typically
  used to generate summary statistics from FASTQ files.\n\nTool homepage: https://github.com/rpetit3/fastq-scan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-scan:1.0.1--h4ac6f70_3
stdout: fastq-scan.out
