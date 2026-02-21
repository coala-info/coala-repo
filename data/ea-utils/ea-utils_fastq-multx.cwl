cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-multx
label: ea-utils_fastq-multx
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
stdout: ea-utils_fastq-multx.out
