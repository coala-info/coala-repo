cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmetl
label: rmetl
doc: "Read-level methylation analysis tool (Note: The provided text appears to be
  a container build log rather than CLI help text; no arguments could be extracted).\n
  \nTool homepage: https://github.com/tjiangHIT/rMETL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmetl:1.0.4--py_0
stdout: rmetl.out
