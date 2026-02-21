cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-join
label: ea-utils_fastq-join
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to initialize a container due to lack of disk space.\n\n
  Tool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
stdout: ea-utils_fastq-join.out
