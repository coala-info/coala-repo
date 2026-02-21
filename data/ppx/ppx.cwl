cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppx
label: ppx
doc: "A tool for programmatic access to proteomics data from public repositories.\n
  \nTool homepage: https://github.com/wfondrie/ppx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppx:1.5.0--pyhdfd78af_0
stdout: ppx.out
