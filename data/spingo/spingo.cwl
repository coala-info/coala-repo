cwlVersion: v1.2
class: CommandLineTool
baseCommand: spingo
label: spingo
doc: "SPecies level IdentificatioN of metaGenOmic amplicons.\n\nTool homepage: https://github.com/homedepot/spingo"
inputs:
  - id: ambiguous
    type:
      - 'null'
      - boolean
    doc: if specified, species which lead to an ambiguous hit will be listed
    inputBinding:
      position: 101
      prefix: --ambiguous
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: number of bootstrap samples
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: database
    type:
      - 'null'
      - File
    doc: path to the fasta format reference database
    inputBinding:
      position: 101
      prefix: --database
  - id: input
    type:
      - 'null'
      - File
    doc: path to the fasta format input file
    inputBinding:
      position: 101
      prefix: --input
  - id: kmersize
    type:
      - 'null'
      - int
    doc: K-mer size
    inputBinding:
      position: 101
      prefix: --kmersize
  - id: processors
    type:
      - 'null'
      - int
    doc: number of processor threads
    inputBinding:
      position: 101
      prefix: --processors
  - id: subsample
    type:
      - 'null'
      - float
    doc: fraction of kmers to be subsampled for bootstrapping. Default is 
      kmersize
    inputBinding:
      position: 101
      prefix: --subsample
  - id: write_index
    type:
      - 'null'
      - boolean
    doc: if specified, index will be written to disk
    inputBinding:
      position: 101
      prefix: --write-index
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spingo:1.3
stdout: spingo.out
