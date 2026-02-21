cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq-seq-pan
label: seq-seq-pan
doc: "A tool for pangenome assembly and analysis (Note: The provided input text contains
  system error logs rather than the tool's help documentation, so specific arguments
  could not be extracted).\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
stdout: seq-seq-pan.out
