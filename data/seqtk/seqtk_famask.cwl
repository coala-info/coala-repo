cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - famask
label: seqtk_famask
doc: "Apply a mask to a FASTA sequence file\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: src_fa
    type: File
    doc: Source FASTA file
    inputBinding:
      position: 1
  - id: mask_fa
    type: File
    doc: Mask FASTA file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_famask.out
