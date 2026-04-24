cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge kmerize
label: strainge_kmerize
doc: "K-merize a given reference sequence or a sample read dataset.\n\nTool homepage:
  The package home page"
inputs:
  - id: sequences
    type:
      type: array
      items: File
    doc: Input sequence files (fasta or fastq by default; optionally compressed 
      with gz or bz2)
    inputBinding:
      position: 1
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Filter output kmers based on kmer spectrum (to prune sequencing errors)
    inputBinding:
      position: 102
      prefix: --filter
  - id: fingerprint_fraction
    type:
      - 'null'
      - float
    doc: 'Fraction of k-mers to keep for a minhash sketch. Default: 0.01. No fingerprint
      will be created if set to zero.'
    inputBinding:
      position: 102
      prefix: --fingerprint-fraction
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size
    inputBinding:
      position: 102
      prefix: --k
  - id: limit
    type:
      - 'null'
      - string
    doc: Only process about this many kmers (can have suffix of M or G)
    inputBinding:
      position: 102
      prefix: --limit
  - id: prune
    type:
      - 'null'
      - string
    doc: Prune singletons after accumulating this (can have suffix of M or G)
    inputBinding:
      position: 102
      prefix: --prune
outputs:
  - id: output
    type: File
    doc: Filename of the output HDF5.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
