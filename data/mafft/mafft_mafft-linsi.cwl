cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafft-linsi
label: mafft_mafft-linsi
doc: "MAFFT L-INS-i is an accurate strategy for multiple sequence alignment, part
  of the MAFFT software suite. (Note: The provided help text contains only system
  error messages and no usage information.)\n\nTool homepage: http://mafft.cbrc.jp/alignment/software/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mafft:7.525--h031d066_1
stdout: mafft_mafft-linsi.out
