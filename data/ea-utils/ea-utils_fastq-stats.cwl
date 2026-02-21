cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-stats
label: ea-utils_fastq-stats
doc: "The provided text does not contain help information for the tool, but rather
  a system error message indicating a failure to build a container image due to lack
  of disk space.\n\nTool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
stdout: ea-utils_fastq-stats.out
