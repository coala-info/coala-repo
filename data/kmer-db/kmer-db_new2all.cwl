cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmer-db
  - new2all
label: kmer-db_new2all
doc: "Count common k-mers between a set of new samples and all the samples in the database\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: multisample_fasta
    type: ['null', boolean]
    doc: "Each sequence in a FASTA file is treated as a separate sample"
    inputBinding:
      position: 1
      prefix: "-multisample-fasta"
  - id: from_kmers
    type: ['null', boolean]
    doc: "Samples are KMC k-mers"
    inputBinding:
      position: 1
      prefix: "-from-kmers"
  - id: from_minhash
    type: ['null', boolean]
    doc: "Samples are minhashed k-mers"
    inputBinding:
      position: 1
      prefix: "-from-minhash"
  - id: sparse
    type: ['null', boolean]
    doc: "Output a sparse matrix"
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
  - id: threads
    type: ['null', int]
    doc: "Number of threads (default: number of available cores)"
    inputBinding:
      position: 1
      prefix: "-t"
  - id: database_in
    type: File
    doc: "K-mer database file"
    inputBinding:
      position: 10
  - id: samples
    type: File
    doc: "FASTA file (fa, fna, fasta, fa.gz, fna.gz, fasta.gz) with one or multiple (-multisample-fasta) samples, or a file with a list of samples (FASTA genomes/reads, KMC k-mers with -from-kmers, minhashed k-mers with -from-minhash)"
    inputBinding:
      position: 11
  - id: sample_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Sample files named in the list file, staged in the working directory so that the names in the list resolve"
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
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sample_files)
      - $(inputs.samples)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
stdout: kmer-db_new2all.out
