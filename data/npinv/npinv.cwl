cwlVersion: v1.2
class: CommandLineTool
baseCommand: npinv
label: npinv
doc: "A tool for detecting non-allelic homologous recombination (NAHR) inversions
  using long-read sequencing data.\n\nTool homepage: https://github.com/haojingshao/npInv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/npinv:1.24--py27_0
stdout: npinv.out
