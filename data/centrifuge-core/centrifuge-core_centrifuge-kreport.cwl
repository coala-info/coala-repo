cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-kreport
label: centrifuge-core_centrifuge-kreport
doc: "centrifuge-kreport creates Kraken-style reports from centrifuge out files.\n\
  \nTool homepage: https://github.com/infphilo/centrifuge"
inputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Centrifuge output file(s)
    inputBinding:
      position: 1
  - id: index_name
    type: string
    doc: Centrifuge index
    inputBinding:
      position: 102
      prefix: -x
  - id: is_count_table
    type:
      - 'null'
      - boolean
    doc: The format of the file is 'taxID<tab>COUNT' instead of the standard 
      Centrifuge output format
    inputBinding:
      position: 102
      prefix: --is-count-table
  - id: min_length
    type:
      - 'null'
      - string
    doc: Require a minimum alignment length to the read
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_score
    type:
      - 'null'
      - string
    doc: Require a minimum score for reads to be counted
    inputBinding:
      position: 102
      prefix: --min-score
  - id: no_lca
    type:
      - 'null'
      - boolean
    doc: Do not report the LCA of multiple assignments, but report count 
      fractions at the taxa.
    inputBinding:
      position: 102
      prefix: --no-lca
  - id: show_zeros
    type:
      - 'null'
      - boolean
    doc: Show clades that have zero reads, too
    inputBinding:
      position: 102
      prefix: --show-zeros
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
stdout: centrifuge-core_centrifuge-kreport.out
