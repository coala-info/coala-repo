cwlVersion: v1.2
class: CommandLineTool
baseCommand: picrust2
label: picrust2
doc: "PICRUSt2 (Phylogenetic Investigation of Communities by Reconstruction of Unobserved
  States) is a software for predicting functional abundances based only on marker
  gene sequences.\n\nTool homepage: https://github.com/picrust/picrust2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
stdout: picrust2.out
