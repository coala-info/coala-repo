cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmer-db
  - minhash
label: kmer-db_minhash
doc: "Store minhashed k-mers (one *.minhash file per sample)\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: fraction
    type: ['null', float]
    doc: "Fraction of all k-mers to be accepted by the minhash filter (default: 0.01)"
    inputBinding:
      position: 1
      prefix: "-f"
  - id: kmer_length
    type: ['null', int]
    doc: "Length of k-mers (default: 18, maximum: 30)"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: multisample_fasta
    type: ['null', boolean]
    doc: "Each sequence in a FASTA file is treated as a separate sample"
    inputBinding:
      position: 1
      prefix: "-multisample-fasta"
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
    doc: "Samples are KMC k-mers"
    inputBinding:
      position: 1
      prefix: "-from-kmers"
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
outputs:
  - id: minhash_files
    type:
      type: array
      items: File
    doc: "Binary files with the filtered k-mers, one *.minhash file per sample"
    outputBinding:
      glob: "*.minhash"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sample_files)
        writable: true
      - entry: $(inputs.samples)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
stdout: kmer-db_minhash.out
