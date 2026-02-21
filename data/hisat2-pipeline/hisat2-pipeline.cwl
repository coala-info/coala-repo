cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat2-pipeline
label: hisat2-pipeline
doc: "A pipeline for HISAT2 (Note: The provided text contains container runtime error
  messages rather than tool help text).\n\nTool homepage: https://github.com/mcamagna/HISAT2-pipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat2-pipeline:1.1.1--pyhdfd78af_0
stdout: hisat2-pipeline.out
