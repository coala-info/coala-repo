cwlVersion: v1.2
class: CommandLineTool
baseCommand: psirc
label: psirc
doc: "psirc (Pseudo-Splicing Identification from RNA-seq and ChIP-seq data)\n\nTool
  homepage: https://github.com/nictru/psirc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
stdout: psirc.out
