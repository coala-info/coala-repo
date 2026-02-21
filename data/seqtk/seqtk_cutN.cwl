cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - cutN
label: seqtk_cutN
doc: "Cut sequences at long N tracts\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: min_size
    type:
      - 'null'
      - int
    doc: min size of N tract
    default: 1000
    inputBinding:
      position: 102
      prefix: -n
  - id: penalty
    type:
      - 'null'
      - int
    doc: penalty for a non-N
    default: 10
    inputBinding:
      position: 102
      prefix: -p
  - id: print_gaps_only
    type:
      - 'null'
      - boolean
    doc: print gaps only, no sequence
    inputBinding:
      position: 102
      prefix: -g
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_cutN.out
