cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafft
label: mafft
doc: "Multiple Sequence Alignment\n\nTool homepage: http://mafft.cbrc.jp/alignment/software/"
inputs:
  - id: input
    type: File
    doc: Input sequences
    inputBinding:
      position: 1
  - id: auto
    type:
      - 'null'
      - boolean
    doc: Automatically select parameters for alignment
    inputBinding:
      position: 102
      prefix: --auto
  - id: clustalout
    type:
      - 'null'
      - boolean
    doc: Output in clustal format
    inputBinding:
      position: 102
      prefix: --clustalout
  - id: dash
    type:
      - 'null'
      - boolean
    doc: Add structural information
    inputBinding:
      position: 102
      prefix: --dash
  - id: ep
    type:
      - 'null'
      - float
    doc: Offset (works like gap extension penalty)
    inputBinding:
      position: 102
      prefix: --ep
  - id: genafpair
    type:
      - 'null'
      - boolean
    doc: Use genafpair for high accuracy alignment
    inputBinding:
      position: 102
      prefix: --genafpair
  - id: globalpair
    type:
      - 'null'
      - boolean
    doc: Use globalpair for high accuracy alignment
    inputBinding:
      position: 102
      prefix: --globalpair
  - id: localpair
    type:
      - 'null'
      - boolean
    doc: Use localpair for high accuracy alignment
    inputBinding:
      position: 102
      prefix: --localpair
  - id: maxiterate
    type:
      - 'null'
      - int
    doc: Maximum number of iterative refinement
    inputBinding:
      position: 102
      prefix: --maxiterate
  - id: op
    type:
      - 'null'
      - float
    doc: Gap opening penalty
    inputBinding:
      position: 102
      prefix: --op
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not report progress
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: Output in aligned order
    inputBinding:
      position: 102
      prefix: --reorder
  - id: retree
    type:
      - 'null'
      - int
    doc: Retree parameter for fast alignment
    inputBinding:
      position: 102
      prefix: --retree
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads (if unsure, --thread -1)
    inputBinding:
      position: 102
      prefix: --thread
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output alignment
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mafft:7.525--h031d066_1
