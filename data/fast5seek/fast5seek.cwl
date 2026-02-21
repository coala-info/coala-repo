cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast5seek
label: fast5seek
doc: "A tool for seeking or indexing FAST5 files (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/mbhall88/fast5seek"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5seek:0.1.1--py35_0
stdout: fast5seek.out
