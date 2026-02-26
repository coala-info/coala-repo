cwlVersion: v1.2
class: CommandLineTool
baseCommand: distmat
label: revoluzer_distmat
doc: "Compute distance matrix between genomes.\n\nTool homepage: https://gitlab.com/Bernt/revoluzer/"
inputs:
  - id: inputfile
    type: File
    doc: Input file containing genome data
    inputBinding:
      position: 1
  - id: compute_crex_distance
    type:
      - 'null'
      - boolean
    doc: compute CREx distance
    inputBinding:
      position: 102
      prefix: --crex
  - id: get_breakpoints
    type:
      - 'null'
      - boolean
    doc: get number of breakpoints
    inputBinding:
      position: 102
      prefix: -b
  - id: get_intervals
    type:
      - 'null'
      - boolean
    doc: get number of intervals (-n|-m must be specified)
    inputBinding:
      position: 102
      prefix: -i
  - id: linear_directed
    type:
      - 'null'
      - boolean
    doc: treat data as linear directed genomes (default circular)
    inputBinding:
      position: 102
      prefix: --lindir
  - id: linear_undirected
    type:
      - 'null'
      - boolean
    doc: treat data as linear undirected genomes (default circular)
    inputBinding:
      position: 102
      prefix: --linund
  - id: print_column_headers
    type:
      - 'null'
      - boolean
    doc: print column headers in the distance matrix
    inputBinding:
      position: 102
      prefix: --header
  - id: print_list_format
    type:
      - 'null'
      - boolean
    doc: print list format instead of matrix
    inputBinding:
      position: 102
      prefix: --list
  - id: print_nexus_format
    type:
      - 'null'
      - boolean
    doc: print nexus format distance matrix
    inputBinding:
      position: 102
      prefix: --nexus
  - id: sign_handling
    type:
      - 'null'
      - string
    doc: 'sign handling. default: '
    inputBinding:
      position: 102
      prefix: --sign
  - id: use_common_intervals
    type:
      - 'null'
      - boolean
    doc: use common intervals
    inputBinding:
      position: 102
      prefix: -m
  - id: use_conserved_intervals
    type:
      - 'null'
      - boolean
    doc: use conserved intervals
    inputBinding:
      position: 102
      prefix: -n
  - id: use_global_perfect_distance
    type:
      - 'null'
      - boolean
    doc: use global instead of pairwise perfect distance
    inputBinding:
      position: 102
      prefix: -M
  - id: weight_intervals_by_length
    type:
      - 'null'
      - boolean
    doc: weight intervals by length
    inputBinding:
      position: 102
      prefix: --lw
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
stdout: revoluzer_distmat.out
