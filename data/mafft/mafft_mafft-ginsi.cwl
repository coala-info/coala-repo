cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafft-ginsi
label: mafft_mafft-ginsi
doc: "MAFFT G-INS-i: A multiple sequence alignment program using a global alignment
  strategy with iterative refinement. (Note: The provided help text contained only
  system error messages and no usage information.)\n\nTool homepage: http://mafft.cbrc.jp/alignment/software/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mafft:7.525--h031d066_1
stdout: mafft_mafft-ginsi.out
