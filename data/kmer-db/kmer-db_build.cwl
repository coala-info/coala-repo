cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmer-db
  - build
label: kmer-db_build
doc: "Build a k-mer database from FASTA genomes/reads, k-mers, or minhashed k-mers\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: kmer_length
    type: ['null', int]
    doc: "Length of k-mers (default: 18, maximum depends on the alphabet - 31 for default nt)"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: fraction
    type: ['null', float]
    doc: "Fraction of all k-mers to be accepted by the minhash filter (default: 1)"
    inputBinding:
      position: 1
      prefix: "-f"
  - id: multisample_fasta
    type: ['null', boolean]
    doc: "Each sequence in a FASTA file is treated as a separate sample"
    inputBinding:
      position: 1
      prefix: "-multisample-fasta"
  - id: extend
    type: ['null', boolean]
    doc: "Extend the existing database (existing_database) with new samples"
    inputBinding:
      position: 1
      prefix: "-extend"
  - id: alphabet
    type: ['null', string]
    doc: "Alphabet: nt (default), aa, aa12_mmseqs, aa11_diamond or aa6_dayhoff"
    inputBinding:
      position: 1
      prefix: "-alphabet"
  - id: preserve_strand
    type: ['null', boolean]
    doc: "Preserve strand instead of taking canonical k-mers (allowed only in nt alphabet; default: off)"
    inputBinding:
      position: 1
      prefix: "-preserve-strand"
  - id: from_kmers
    type: ['null', boolean]
    doc: "Build the database from KMC k-mers"
    inputBinding:
      position: 1
      prefix: "-from-kmers"
  - id: from_minhash
    type: ['null', boolean]
    doc: "Build the database from minhashed k-mers"
    inputBinding:
      position: 1
      prefix: "-from-minhash"
  - id: threads
    type: ['null', int]
    doc: "Number of threads (default: number of available cores)"
    inputBinding:
      position: 1
      prefix: "-t"
  - id: samples
    type: File
    doc: "FASTA file (fa, fna, fasta, fa.gz, fna.gz, fasta.gz) with one or multiple (-multisample-fasta) samples, or a file with a list of samples (FASTA genomes/reads, KMC k-mers with -from-kmers, minhashed k-mers with -from-minhash)"
    inputBinding:
      position: 10
  - id: sample_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Sample files named in the list file, staged in the working directory so that the names in the list resolve"
  - id: existing_database
    type: ['null', File]
    doc: "Existing database to extend with -extend; it must have the same name as the output database"
  - id: database
    type: string
    doc: "Output file with the generated k-mer database"
    inputBinding:
      position: 11
outputs:
  - id: database_out
    type: File
    doc: "Generated k-mer database"
    outputBinding:
      glob: $(inputs.database)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sample_files)
      - $(inputs.samples)
      - entry: $(inputs.existing_database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
stdout: kmer-db_build.out
