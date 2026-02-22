cwlVersion: v1.2
class: CommandLineTool
baseCommand: bppphyview
label: bppphyview
doc: "A tool from the Bio++ suite for phylogenetic tree visualization. (Note: The
  provided text contains system error messages regarding container execution and does
  not include specific usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/BioPP/bppphyview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bppphyview:v0.6.1-1-deb_cv1
stdout: bppphyview.out
