cwlVersion: v1.2
class: CommandLineTool
baseCommand: guidemaker
label: guidemaker
doc: "GuideMaker is a tool for designing CRISPR-Cas guide RNA (gRNA) pools. (Note:
  The provided text contains system error logs rather than help documentation, so
  specific arguments could not be extracted.)\n\nTool homepage: https://github.com/USDA-ARS-GBRU/GuideMaker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guidemaker:0.4.2--pyhdfd78af_0
stdout: guidemaker.out
