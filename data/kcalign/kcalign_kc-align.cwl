cwlVersion: v1.2
class: CommandLineTool
baseCommand: kc-align
label: kcalign_kc-align
doc: "K-mer based Codon Alignment (Note: The provided help text contains only container
  runtime error messages and no usage information.)\n\nTool homepage: https://github.com/davebx/kc-align"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcalign:1.0.2--py_0
stdout: kcalign_kc-align.out
