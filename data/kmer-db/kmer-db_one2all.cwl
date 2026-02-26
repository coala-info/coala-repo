cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer-db one2all
label: kmer-db_one2all
doc: "Counting common kmers between single sample and all the samples in the database\n\
  \nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: database
    type: File
    doc: k-mer database file.
    inputBinding:
      position: 1
  - id: sample
    type: File
    doc: 'query sample in one of the supported formats: FASTA genomes/reads (default),
      KMC k-mers (-from-kmers), or minhashed k-mers (-from-minhash)'
    inputBinding:
      position: 2
  - id: from_kmers
    type:
      - 'null'
      - boolean
    doc: Indicates that the sample is in KMC k-mer format
    inputBinding:
      position: 103
      prefix: -from-kmers
  - id: from_minhash
    type:
      - 'null'
      - boolean
    doc: Indicates that the sample is in minhashed k-mer format
    inputBinding:
      position: 103
      prefix: -from-minhash
outputs:
  - id: common_table
    type: File
    doc: CSV table with number of common k-mers.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
