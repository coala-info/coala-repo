cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaseq-all
label: metaseq-all
doc: The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build or run a container due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaseq-all:0.5.6--2
stdout: metaseq-all.out
