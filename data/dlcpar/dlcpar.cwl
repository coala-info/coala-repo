cwlVersion: v1.2
class: CommandLineTool
baseCommand: dlcpar
label: dlcpar
doc: "A tool for reconciling gene trees with species trees (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/wutron/dlcpar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dlcpar:1.0--py27_0
stdout: dlcpar.out
