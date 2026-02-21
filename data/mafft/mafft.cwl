cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafft
label: mafft
doc: "Multiple alignment program for amino acid or nucleotide sequences (Note: The
  provided help text contains only container execution errors and no usage information).\n
  \nTool homepage: http://mafft.cbrc.jp/alignment/software/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mafft:7.525--h031d066_1
stdout: mafft.out
