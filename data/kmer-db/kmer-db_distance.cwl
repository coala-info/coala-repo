cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmer-db
  - distance
label: kmer-db_distance
doc: "Calculate similarities/distances on the basis of common k-mers\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: phylip_out
    type: ['null', boolean]
    doc: "Store output distance matrix in a Phylip format"
    inputBinding:
      position: 1
      prefix: "-phylip-out"
  - id: sparse
    type: ['null', boolean]
    doc: "Output a sparse matrix (only for dense input matrices - sparse input always produce sparse output)"
    inputBinding:
      position: 1
      prefix: "-sparse"
  - id: min_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -min
    doc: "Retain elements with <criterion> greater than or equal to <value>, written [<criterion>:]<value>; criterion is num-kmers (default) or jaccard, min, max, cosine, mash, ani, ani-shorter. Can be given several times"
    inputBinding:
      position: 1
  - id: max_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -max
    doc: "Retain elements with <criterion> lower than or equal to <value>, written [<criterion>:]<value>. Can be given several times"
    inputBinding:
      position: 1
  - id: measure
    type: string
    doc: "Name of the similarity/distance measure: jaccard, min, max, cosine, mash, ani or ani-shorter"
    inputBinding:
      position: 10
  - id: common_table_in
    type: File
    doc: "CSV table with a number of common k-mers (output of all2all, all2all-sp or new2all)"
    inputBinding:
      position: 11
  - id: output_table
    type: string
    doc: "Output CSV table with calculated distances"
    inputBinding:
      position: 12
outputs:
  - id: output_table_out
    type: File
    doc: "Table with the calculated distances"
    outputBinding:
      glob: $(inputs.output_table)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
stdout: kmer-db_distance.out
