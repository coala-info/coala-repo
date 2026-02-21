cwlVersion: v1.2
class: CommandLineTool
baseCommand: generax
label: generax
doc: "GeneRax is a tool for species tree-aware maximum likelihood gene tree inference
  and reconciliation.\n\nTool homepage: https://github.com/benoitmorel/generax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/generax:2.1.3--hf316886_3
stdout: generax.out
