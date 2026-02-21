cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq
label: fastq
doc: "The provided text does not contain help information or usage instructions for
  the 'fastq' tool; it contains error logs related to a container runtime failure
  (no space left on device).\n\nTool homepage: https://github.com/not-a-feature/fastq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq:2.0.4--pyhdfd78af_0
stdout: fastq.out
