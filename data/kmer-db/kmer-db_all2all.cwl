cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer-db all2all
label: kmer-db_all2all
doc: "Counting common k-mers for all the samples in the database\n\nTool homepage:
  https://github.com/refresh-bio/kmer-db"
inputs:
  - id: database
    type: File
    doc: k-mer database file
    inputBinding:
      position: 1
  - id: buffer
    type:
      - 'null'
      - int
    doc: "size of cache buffer in megabytes\n                      (use L3 size for
      Intel CPUs and L2 for AMD to maximize performance; default: 8)"
    inputBinding:
      position: 102
      prefix: -buffer
  - id: max_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: retains elements with <criterion> lower than or equal to <value> (see 
      details below)
    inputBinding:
      position: 102
      prefix: -max
  - id: min_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: retains elements with <criterion> greater than or equal to <value> (see
      details below)
    inputBinding:
      position: 102
      prefix: -min
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: produce sparse matrix as output
    inputBinding:
      position: 102
      prefix: -sparse
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: number of available cores)'
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: common_table
    type: File
    doc: comma-separated table with number of common k-mers
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
