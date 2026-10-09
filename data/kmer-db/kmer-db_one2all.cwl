cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmer-db
  - one2all
label: kmer-db_one2all
doc: "Count common k-mers between a single sample and all the samples in the database\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: from_kmers
    type: ['null', boolean]
    doc: "Sample is a KMC k-mers file"
    inputBinding:
      position: 1
      prefix: "-from-kmers"
  - id: from_minhash
    type: ['null', boolean]
    doc: "Sample is a minhashed k-mers file"
    inputBinding:
      position: 1
      prefix: "-from-minhash"
  - id: database_in
    type: File
    doc: "K-mer database file"
    inputBinding:
      position: 10
  - id: sample
    type: File
    doc: "Query sample: FASTA genomes/reads (default), KMC k-mers (-from-kmers), or minhashed k-mers (-from-minhash)"
    inputBinding:
      position: 11
  - id: common_table
    type: string
    doc: "Output CSV table with number of common k-mers"
    inputBinding:
      position: 12
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
stdout: kmer-db_one2all.out
