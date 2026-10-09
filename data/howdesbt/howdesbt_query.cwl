cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - query
label: howdesbt_query
doc: "query a sequence bloom tree\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: "names of query files; each is either a fasta file or a file with one nucleotide sequence per line"
    inputBinding:
      position: 101
  - id: tree
    type: File
    doc: "name of the tree topology file"
    inputBinding:
      position: 102
      prefix: "--tree="
      separate: false
  - id: filters
    type:
      type: array
      items: File
    doc: "the bloom filter files named in the topology file (staged in the working directory)"
  - id: threshold
    type:
      - 'null'
      - float
    doc: "fraction of query kmers that must be present in a leaf to be considered a match; between 0 and 1 (default is 0.7)"
    inputBinding:
      position: 103
      prefix: "--threshold="
      separate: false
  - id: adjust
    type:
      - 'null'
      - boolean
    doc: "adjust reported number of kmers present, compensating for bloom filter false positives"
    inputBinding:
      position: 104
      prefix: "--adjust"
  - id: sort
    type:
      - 'null'
      - boolean
    doc: "sort matched leaves by the number of query kmers present, and report the number of kmers present"
    inputBinding:
      position: 105
      prefix: "--sort"
  - id: leafonly
    type:
      - 'null'
      - boolean
    doc: "disregard internal tree nodes and perform the query only at the leaves"
    inputBinding:
      position: 106
      prefix: "--leafonly"
  - id: distinctkmers
    type:
      - 'null'
      - boolean
    doc: "perform the query counting each distinct kmer only once"
    inputBinding:
      position: 107
      prefix: "--distinctkmers"
  - id: consistencycheck
    type:
      - 'null'
      - boolean
    doc: "before searching, check that bloom filter properties are consistent across the tree"
    inputBinding:
      position: 108
      prefix: "--consistencycheck"
  - id: justcountkmers
    type:
      - 'null'
      - boolean
    doc: "just report the number of kmers in each query, and quit"
    inputBinding:
      position: 109
      prefix: "--justcountkmers"
  - id: countallkmerhits
    type:
      - 'null'
      - boolean
    doc: "report the number of kmers that 'hit', for each query/leaf"
    inputBinding:
      position: 110
      prefix: "--countallkmerhits"
  - id: stat_nodesexamined
    type:
      - 'null'
      - boolean
    doc: "report the count of nodes examined for each query (as a comment in the output)"
    inputBinding:
      position: 111
      prefix: "--stat:nodesexamined"
  - id: time
    type:
      - 'null'
      - boolean
    doc: "report wall time and node i/o time"
    inputBinding:
      position: 112
      prefix: "--time"
  - id: out
    type:
      - 'null'
      - string
    doc: "file for query results; if not provided, results are written to stdout"
    inputBinding:
      position: 113
      prefix: "--out="
      separate: false
outputs:
  - id: query_results
    type:
      - 'null'
      - File
    doc: "query results file"
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.filters)
      - $(inputs.tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
stdout: howdesbt_query.out
