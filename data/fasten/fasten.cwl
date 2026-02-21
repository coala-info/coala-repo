cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten
label: fasten
doc: "A toolkit for manipulating FASTQ files. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  tool arguments.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten.out
