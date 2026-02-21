cwlVersion: v1.2
class: CommandLineTool
baseCommand: cirtap
label: cirtap
doc: "Circular RNA identification tool (Note: The provided text appears to be a container
  build error log rather than help text; no arguments could be extracted from the
  input).\n\nTool homepage: https://github.com/MGXlab/cirtap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
stdout: cirtap.out
