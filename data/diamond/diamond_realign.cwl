cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - realign
label: diamond_realign
doc: Realign sequences using the DIAMOND engine
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: db
    type: File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: out
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --out
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: comp_based_stats
    type:
      - 'null'
      - int
    doc: composition based statistics mode (0-4)
    inputBinding:
      position: 101
      prefix: --comp-based-stats
  - id: masking
    type:
      - 'null'
      - string
    doc: masking algorithm (none, seg, tantan=default)
    inputBinding:
      position: 101
      prefix: --masking
  - id: soft_masking
    type:
      - 'null'
      - string
    doc: soft masking (none=default, seg, tantan)
    inputBinding:
      position: 101
      prefix: --soft-masking
  - id: outfmt
    type:
      - 'null'
      - type: array
        items: string
    doc: output format (0, 5, 6, 100, 101, 102, 103, 104). Values 6 and 104 may 
      be followed by a space-separated list of keywords.
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: qnum_offset
    type:
      - 'null'
      - int
    doc: offset added to query ordinal id (qnum field)
    inputBinding:
      position: 101
      prefix: --qnum-offset
  - id: snum_offset
    type:
      - 'null'
      - int
    doc: offset added to subject ordinal id (snum field)
    inputBinding:
      position: 101
      prefix: --snum-offset
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: Memory limit in GB
    inputBinding:
      position: 101
      prefix: --memory-limit
  - id: clusters
    type:
      - 'null'
      - File
    doc: Clustering input file mapping sequences to representatives
    inputBinding:
      position: 101
      prefix: --clusters
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
s:url: https://github.com/bbuchfink/diamond
$namespaces:
  s: https://schema.org/
