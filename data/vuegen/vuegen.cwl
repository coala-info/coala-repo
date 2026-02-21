cwlVersion: v1.2
class: CommandLineTool
baseCommand: vuegen
label: vuegen
doc: "A tool for generating VUE (Variant of Unknown Significance Evidence) reports
  or related genomic data visualizations.\n\nTool homepage: https://github.com/Multiomics-Analytics-Group/vuegen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vuegen:0.5.1--pyhdfd78af_0
stdout: vuegen.out
