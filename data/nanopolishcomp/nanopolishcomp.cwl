cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanopolishcomp
label: nanopolishcomp
doc: "NanopolishComp is a Python3 package for downstream analysis of Nanopolish output.
  Note: The provided input text contains system error messages rather than tool help
  documentation.\n\nTool homepage: https://github.com/a-slide/NanopolishComp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolishcomp:0.6.12--py_0
stdout: nanopolishcomp.out
