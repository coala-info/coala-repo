cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow
label: nextflow
doc: "The provided text does not contain help information or a description of the
  tool; it contains environment info and a fatal error log regarding container image
  conversion and disk space.\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.3--h2a3209d_1
stdout: nextflow.out
