cwlVersion: v1.2
class: CommandLineTool
baseCommand: is_a_parent_of_b
label: conifer_is_a_parent_of_b
doc: "Check whether taxid1 is an ancestor of taxid2 in a Kraken2 taxonomy (taxo.k2d);
  prints 1 (yes) or 0 (no) for one pair or for each pair in a list file.\n\nTool homepage:
  https://github.com/Ivarz/Conifer/"
inputs:
  - id: db
    type: File
    doc: Kraken2 taxonomy file (taxo.k2d)
    inputBinding:
      position: 101
      prefix: --db
  - id: taxid1
    type:
      - 'null'
      - string
    doc: first taxid (the putative ancestor)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: taxid2
    type:
      - 'null'
      - string
    doc: second taxid (the putative descendant)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: taxid_pair_list
    type:
      - 'null'
      - File
    doc: tab-separated file with one taxid pair (taxid1, taxid2) per line
    inputBinding:
      position: 101
      prefix: --list
  - id: csv
    type:
      - 'null'
      - File
    doc: file with lines 'taxid<TAB>taxid,taxid,...'; reports 1 when the first taxid
      is related to any taxid in the comma-separated list (option from the source,
      not in the usage text)
    inputBinding:
      position: 101
      prefix: --csv
  - id: any
    type:
      - 'null'
      - boolean
    doc: report 1 when either taxid is an ancestor of the other
    inputBinding:
      position: 101
      prefix: --any
  - id: labels
    type:
      - 'null'
      - boolean
    doc: print the two taxids before the result
    inputBinding:
      position: 101
      prefix: --labels
  - id: names
    type:
      - 'null'
      - boolean
    doc: print the taxon names before the result (option from the source, not in the
      usage text)
    inputBinding:
      position: 101
      prefix: --names
outputs:
  - id: stdout
    type: stdout
    doc: one result line (1 or 0) per taxid pair
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
stdout: conifer_is_a_parent_of_b.out
