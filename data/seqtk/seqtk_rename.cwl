cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - rename
label: seqtk_rename
doc: "Rename sequences in a FASTA/FASTQ file\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for renamed sequences
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_rename.out
