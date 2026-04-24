cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - hety
label: seqtk_hety
doc: "Analyze heterozygosity in a FASTA file\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: mask_lowercase
    type:
      - 'null'
      - boolean
    doc: treat lowercases as masked
    inputBinding:
      position: 102
      prefix: -m
  - id: start_positions
    type:
      - 'null'
      - int
    doc: '# start positions in a window'
    inputBinding:
      position: 102
      prefix: -t
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_hety.out
