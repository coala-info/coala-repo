cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-multx
label: fastq-multx
doc: "The provided text does not contain help information for fastq-multx; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/brwnj/fastq-multx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-multx:1.4.2--h7d875b9_1
stdout: fastq-multx.out
