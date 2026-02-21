cwlVersion: v1.2
class: CommandLineTool
baseCommand: vafator
label: vafator
doc: "Vafator is a tool for annotating VAF (Variant Allele Frequency) for a set of
  variants across multiple BAM files.\n\nTool homepage: https://github.com/tron-bioinformatics/vafator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vafator:2.2.2--pyhdfd78af_0
stdout: vafator.out
