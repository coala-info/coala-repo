cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - mutfa
label: seqtk_mutfa
doc: "Mutate a FASTA file based on a SNP list. The SNP file should contain at least
  four columns: 'chr', '1-based-pos', 'any', and 'base-changed-to'.\n\nTool homepage:
  https://github.com/lh3/seqtk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: input_snp
    type: File
    doc: 'Input SNP file containing at least four columns: chr, 1-based-pos, any,
      base-changed-to'
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_mutfa.out
