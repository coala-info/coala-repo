cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer-db distance
label: kmer-db_distance
doc: "Calculating similarities/distances on the basis of common k-mers\n\nTool homepage:
  https://github.com/refresh-bio/kmer-db"
inputs:
  - id: measure
    type: string
    doc: 'name of the similarity/distance measure to be calculated, one of the following:
      jaccard, min, max, cosine, mash, ani, ani-shorter.'
    inputBinding:
      position: 1
  - id: common_table
    type: File
    doc: CSV table with a number of common k-mers
    inputBinding:
      position: 2
  - id: max_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: retains elements with <criterion> lower than or equal to <value> (see 
      details below)
    inputBinding:
      position: 103
      prefix: -max
  - id: min_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: retains elements with <criterion> greater than or equal to <value> (see
      details below)
    inputBinding:
      position: 103
      prefix: -min
  - id: phylip_out
    type:
      - 'null'
      - boolean
    doc: store output distance matrix in a Phylip format
    inputBinding:
      position: 103
      prefix: -phylip-out
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: outputs a sparse matrix (only for dense input matrices - sparse input 
      always produce sparse output)
    inputBinding:
      position: 103
      prefix: -sparse
outputs:
  - id: output_table
    type: File
    doc: CSV table with calculated distances
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
