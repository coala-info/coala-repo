cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmer-db
  - all2all-sp
label: kmer-db_all2all-sp
doc: "Count common k-mers for all the samples in the database (sparse computation)\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: buffer
    type: ['null', int]
    doc: "Size of cache buffer in megabytes (use L3 size for Intel CPUs and L2 for AMD to maximize performance; default: 8)"
    inputBinding:
      position: 1
      prefix: "-buffer"
  - id: threads
    type: ['null', int]
    doc: "Number of threads (default: number of available cores)"
    inputBinding:
      position: 1
      prefix: "-t"
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
  - id: sample_rows
    type: ['null', string]
    doc: "Retain <count> elements in every row using random selection (no criterion) or the best elements with respect to <criterion>, written [<criterion>:]<count>"
    inputBinding:
      position: 1
      prefix: "-sample-rows"
  - id: database_in
    type: File
    doc: "K-mer database file"
    inputBinding:
      position: 10
  - id: common_table
    type: string
    doc: "Output comma-separated table with number of common k-mers"
    inputBinding:
      position: 11
outputs:
  - id: common_table_out
    type: File
    doc: "Table with the number of common k-mers"
    outputBinding:
      glob: $(inputs.common_table)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
stdout: kmer-db_all2all-sp.out
