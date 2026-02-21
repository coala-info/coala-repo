cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pandora
  - seq2path
label: pandora_seq2path
doc: "For each sequence, return the path through the PRG\n\nTool homepage: https://github.com/rmcolq/pandora"
inputs:
  - id: prg
    type: File
    doc: PRG to index (in fasta format)
    inputBinding:
      position: 1
  - id: bottom
    type:
      - 'null'
      - boolean
    doc: Output the bottom path through each local PRG
    inputBinding:
      position: 102
      prefix: --bottom
  - id: flag
    type:
      - 'null'
      - boolean
    doc: output success/fail rather than the node path
    inputBinding:
      position: 102
      prefix: --flag
  - id: input
    type:
      - 'null'
      - File
    doc: Fast{a,q} of sequences to output paths through the PRG for
    inputBinding:
      position: 102
      prefix: --input
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for (w,k)-minimizers
    default: 15
    inputBinding:
      position: 102
      prefix: -k
  - id: top
    type:
      - 'null'
      - boolean
    doc: Output the top path through each local PRG
    inputBinding:
      position: 102
      prefix: --top
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity of logging. Repeat for increased verbosity
    inputBinding:
      position: 102
      prefix: -v
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for (w,k)-minimizers (must be <=k)
    default: 14
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
stdout: pandora_seq2path.out
