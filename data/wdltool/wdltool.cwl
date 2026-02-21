cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdltool
label: wdltool
doc: "\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
stdout: wdltool.out
