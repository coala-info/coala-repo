cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmer-db
  - minhash
label: kmer-db_minhash
doc: "Storing minhashed k-mers\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: samples
    type: string
    doc: "one of the following : \n        a. FASTA file (fa, fna, fasta, fa.gz, fna.gz,
      fasta.gz) with one or multiple (-multisample-fasta) samples\n        b. file
      with list of samples in one of the formats: \n            * FASTA genomes/reads
      (default),\n            * KMC k-mers (-from-kmers),"
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: "alphabet: * nt (4 symbol nucleotide with indistinguishable T/U; default)\n\
      \        * aa (20 symbol amino acid)\n        * aa12_mmseqs (amino acid reduced
      to 12 symbols as in MMseqs: AST,C,DN,EQ,FY,G,H,IV,KR,LM,P,W\n        * aa11_diamond
      (amino acid reduced to 11 symbols as in Diamond: KREDQN,C,G,H,ILV,M,F,Y,W,P,STA\n\
      \        * aa6_dayhoff (amino acid reduced to 6 symbols as proposed by Dayhoff:
      STPAG,NDEQ,HRK,MILV,FYW,C"
    default: nt
    inputBinding:
      position: 102
      prefix: -alphabet
  - id: fraction
    type:
      - 'null'
      - float
    doc: fraction of all k-mers to be accepted by the minhash filter
    default: 0.01
    inputBinding:
      position: 102
      prefix: -f
  - id: from_kmers
    type:
      - 'null'
      - boolean
    doc: Indicates that the input samples are KMC k-mers.
    inputBinding:
      position: 102
      prefix: -from-kmers
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of k-mers
    default: 18
    inputBinding:
      position: 102
      prefix: -k
  - id: multisample_fasta
    type:
      - 'null'
      - boolean
    doc: each sequence in a FASTA file is treated as a separate sample
    inputBinding:
      position: 102
      prefix: -multisample-fasta
  - id: preserve_strand
    type:
      - 'null'
      - boolean
    doc: 'preserve strand instead of taking canonical k-mers (allowed only in nt alphabet;
      default: off)'
    default: false
    inputBinding:
      position: 102
      prefix: -preserve-strand
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
stdout: kmer-db_minhash.out
