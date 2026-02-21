cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyseq-align
label: pyseq-align
doc: "A tool for sequence alignment (Note: The provided text contains container build
  errors rather than help documentation).\n\nTool homepage: https://github.com/Lioscro/pyseq-align"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseq-align:1.0.2--py39hbcbf7aa_5
stdout: pyseq-align.out
