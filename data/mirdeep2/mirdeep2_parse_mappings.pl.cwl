cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parse_mappings.pl
label: mirdeep2_parse_mappings.pl
doc: "Parse an arf mapping file and discard selected mappings\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: file_arf
    type: File
    doc: Mapping file in arf format
    inputBinding:
      position: 1
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: Discard mappings of edit distance higher than this
    inputBinding:
      position: 101
      prefix: -a
  - id: min_query_length
    type:
      - 'null'
      - int
    doc: Discard mappings of read queries shorter than this
    inputBinding:
      position: 101
      prefix: -b
  - id: max_query_length
    type:
      - 'null'
      - int
    doc: Discard mappings of read queries longer than this
    inputBinding:
      position: 101
      prefix: -c
  - id: keep_queries
    type:
      - 'null'
      - File
    doc: Discard read queries not in this file (one id per line)
    inputBinding:
      position: 101
      prefix: -d
  - id: discard_queries
    type:
      - 'null'
      - File
    doc: Discard read queries in this file (one id per line)
    inputBinding:
      position: 101
      prefix: -e
  - id: keep_dbs
    type:
      - 'null'
      - File
    doc: Discard reference dbs not in this file (one id per line)
    inputBinding:
      position: 101
      prefix: -f
  - id: discard_dbs
    type:
      - 'null'
      - File
    doc: Discard reference dbs in this file (one id per line)
    inputBinding:
      position: 101
      prefix: -g
  - id: discard_suboptimal
    type:
      - 'null'
      - boolean
    doc: Discard remaining suboptimal mappings
    inputBinding:
      position: 101
      prefix: -h
  - id: max_remaining_mappings
    type:
      - 'null'
      - int
    doc: Discard remaining suboptimal mappings and discard any reads that have more remaining mappings than this
    inputBinding:
      position: 101
      prefix: -i
  - id: remove_unmatched_3p
    type:
      - 'null'
      - boolean
    doc: Remove any unmatched nucleotides in the very 3' end
    inputBinding:
      position: 101
      prefix: -j
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Output progress to standard error
    inputBinding:
      position: 101
      prefix: -k
outputs:
  - id: stdout
    type: stdout
    doc: Filtered mappings in arf format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: parsed_mappings.arf
