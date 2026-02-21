cwlVersion: v1.2
class: CommandLineTool
baseCommand: modlamp
label: modlamp
doc: "A Python package for antimicrobial peptide (AMP) design and analysis. Note:
  The provided text is a system error log indicating a 'no space left on device' failure
  during container image retrieval and does not contain command-line argument definitions.\n
  \nTool homepage: http://modlamp.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/modlamp:4.3.2--pyh7e72e81_0
stdout: modlamp.out
