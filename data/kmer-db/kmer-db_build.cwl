cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmer-db
  - build
label: kmer-db_build
doc: "Building a database\n\nTool homepage: https://github.com/refresh-bio/kmer-db"
inputs:
  - id: samples
    type: File
    doc: "one of the following:\na. FASTA file (fa, fna, fasta, fa.gz, fna.gz, fasta.gz)
      with one or multiple (-multisample-fasta) samples\nb. file with list of samples
      in one of the formats: \n    * FASTA genomes/reads (default),\n    * KMC k-mers
      (-from-kmers),\n    * minhashed k-mers (-from-minhash)"
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: 'alphabet: * nt (4 symbol nucleotide with indistinguishable T/U; default)
      * aa (20 symbol amino acid) * aa12_mmseqs (amino acid reduced to 12 symbols
      as in MMseqs: AST,C,DN,EQ,FY,G,H,IV,KR,LM,P,W * aa11_diamond (amino acid reduced
      to 11 symbols as in Diamond: KREDQN,C,G,H,ILV,M,F,Y,W,P,STA * aa6_dayhoff (amino
      acid reduced to 6 symbols as proposed by Dayhoff: STPAG,NDEQ,HRK,MILV,FYW,C'
    default: nt
    inputBinding:
      position: 102
  - id: extend
    type:
      - 'null'
      - boolean
    doc: extend the existing database with new samples
    inputBinding:
      position: 102
  - id: fraction
    type:
      - 'null'
      - float
    doc: 'fraction of all k-mers to be accepted by the minhash filter (default: 1)'
    default: 1
    inputBinding:
      position: 102
      prefix: -f
  - id: from_kmers
    type:
      - 'null'
      - boolean
    doc: Build database from KMC k-mers
    inputBinding:
      position: 102
  - id: from_minhash
    type:
      - 'null'
      - boolean
    doc: Build database from minhashed k-mers
    inputBinding:
      position: 102
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'length of k-mers (default: 18, maximum depends on the alphabet - 31 for
      default nt)'
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
  - id: preserve_strand
    type:
      - 'null'
      - boolean
    doc: 'preserve strand instead of taking canonical k-mers (allowed only in nt alphabet;
      default: off)'
    default: false
    inputBinding:
      position: 102
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: number of available cores)'
    default: number of available cores
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: database
    type: File
    doc: file with generated k-mer database
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-db:2.3.1--h9ee0642_0
