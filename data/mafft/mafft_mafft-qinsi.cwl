cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafft-qinsi
label: mafft_mafft-qinsi
doc: "MAFFT-Q-I-NS-i is a high-accuracy multiple sequence alignment method for RNA
  sequences that utilizes secondary structure information. (Note: The provided help
  text contained container execution errors rather than command usage; no arguments
  could be extracted from the input.)\n\nTool homepage: http://mafft.cbrc.jp/alignment/software/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mafft:7.525--h031d066_1
stdout: mafft_mafft-qinsi.out
