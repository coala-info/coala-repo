cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - colorid_bv
  - search
label: colorid_bv_search
doc: "does a bigsi search on one or more fasta/fastq.gz files\n\nTool homepage: https://github.com/hcdenbakker/colorid_bv"
inputs:
  - id: bigsi
    type: File
    doc: Sets the name of the index file for search
    inputBinding:
      position: 101
      prefix: --bigsi
  - id: filter
    type:
      - 'null'
      - int
    doc: set minimum k-mer frequency
    inputBinding:
      position: 101
      prefix: --filter
  - id: gene_search
    type:
      - 'null'
      - boolean
    doc: If set('-g'), the proportion of kmers from the query matching the entries
      in the index will be reported
    inputBinding:
      position: 101
      prefix: --gene_search
  - id: multi_fasta
    type:
      - 'null'
      - boolean
    doc: If set('-m'), each accession in a multifasta will betreated as a separate
      query, currently only with the -s option
    inputBinding:
      position: 101
      prefix: --multi_fasta
  - id: p_shared
    type:
      - 'null'
      - float
    doc: set minimum proportion of shared k-mers with a reference
    inputBinding:
      position: 101
      prefix: --p_shared
  - id: perfect_search
    type:
      - 'null'
      - boolean
    doc: If ('-s') is set, the fast 'perfect match' algorithm will be used
    inputBinding:
      position: 101
      prefix: --perfect_search
  - id: quality
    type:
      - 'null'
      - int
    doc: minimum phred score to keep basepairs within read
    default: 15
    inputBinding:
      position: 101
      prefix: --quality
  - id: query
    type: File
    doc: query file(-s)fastq.gz
    inputBinding:
      position: 101
      prefix: --query
  - id: reverse
    type:
      - 'null'
      - File
    doc: reverse file(-s)fastq.gz
    default: none
    inputBinding:
      position: 101
      prefix: --reverse
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If ('-v') the output will be verbose!
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
stdout: colorid_bv_search.out
