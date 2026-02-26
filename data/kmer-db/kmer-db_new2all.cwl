cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer-db_new2all
label: kmer-db_new2all
doc: "Counting common kmers between set of new samples and all the samples in the
  database\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: database
    type: File
    doc: k-mer database file
    inputBinding:
      position: 1
  - id: samples
    type: File
    doc: "one of the following : \n        a. FASTA file (fa, fna, fasta, fa.gz, fna.gz,
      fasta.gz) with one or multiple (-multisample-fasta) samples\n        b. file
      with list of samples in one of the formats: \n            * FASTA genomes/reads
      (default),\n            * KMC k-mers (-from-kmers),\n            * minhashed
      k-mers (-from-minhash)"
    inputBinding:
      position: 2
  - id: from_kmers
    type:
      - 'null'
      - boolean
    doc: Input samples are in KMC k-mers format
    inputBinding:
      position: 103
  - id: from_minhash
    type:
      - 'null'
      - boolean
    doc: Input samples are in minhashed k-mers format
    inputBinding:
      position: 103
  - id: max_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: retains elements with <criterion> lower than or equal to <value>
    inputBinding:
      position: 103
      prefix: -max
  - id: min_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: retains elements with <criterion> greater than or equal to <value>
    inputBinding:
      position: 103
      prefix: -min
  - id: multisample_fasta
    type:
      - 'null'
      - boolean
    doc: each sequence in a FASTA file is treated as a separate sample
    inputBinding:
      position: 103
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: outputs a sparse matrix
    inputBinding:
      position: 103
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: common_table
    type: File
    doc: CSV table with number of common k-mers
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
