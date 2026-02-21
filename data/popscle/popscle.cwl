cwlVersion: v1.2
class: CommandLineTool
baseCommand: popscle
label: popscle
doc: "A suite of algorithms for population-scale single-cell genomics analysis, including
  demultiplexing and doublet detection.\n\nTool homepage: https://github.com/statgen/popscle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle.out
