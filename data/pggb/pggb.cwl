cwlVersion: v1.2
class: CommandLineTool
baseCommand: pggb
label: pggb
doc: "The PanGenome Graph Builder (pggb) renders a collection of sequences into a
  pangenome graph. Note: The provided input text appears to be a container execution
  error log rather than help text, so no arguments could be extracted from the source.\n
  \nTool homepage: https://github.com/pangenome/pggb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb.out
