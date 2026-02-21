cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - realign
label: diamond_realign
doc: "Realign sequences using the DIAMOND algorithm\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: clusters
    type:
      - 'null'
      - File
    doc: Clustering input file mapping sequences to representatives
    inputBinding:
      position: 101
      prefix: --clusters
  - id: comp_based_stats
    type:
      - 'null'
      - int
    doc: composition based statistics mode (0-4)
    inputBinding:
      position: 101
      prefix: --comp-based-stats
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: masking
    type:
      - 'null'
      - string
    doc: masking algorithm (none, seg, tantan=default)
    default: tantan
    inputBinding:
      position: 101
      prefix: --masking
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: Memory limit in GB
    default: 16G
    inputBinding:
      position: 101
      prefix: --memory-limit
  - id: outfmt
    type:
      - 'null'
      - type: array
        items: string
    doc: output format. Values 6 and 104 may be followed by a space-separated 
      list of keywords.
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: soft_masking
    type:
      - 'null'
      - string
    doc: soft masking (none=default, seg, tantan)
    default: none
    inputBinding:
      position: 101
      prefix: --soft-masking
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
