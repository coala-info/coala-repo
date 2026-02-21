cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafft-einsi
label: mafft_mafft-einsi
doc: "MAFFT is a multiple sequence alignment program. The einsi flavor (E-INS-i) is
  a strategy suitable for sequences containing large unalignable regions.\n\nTool
  homepage: http://mafft.cbrc.jp/alignment/software/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mafft:7.525--h031d066_1
stdout: mafft_mafft-einsi.out
