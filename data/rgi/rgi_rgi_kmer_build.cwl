cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - kmer_build
label: rgi_rgi_kmer_build
doc: "Builds the k-mer sets for CARD*kmers.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: number of kmers to query at a time using pyahocorasick--the greater the number the more memory usage (default=100,000)
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: card
    type: File
    doc: fasta file of CARD reference sequences. If missing, run 'rgi card_annotation' to generate.
    inputBinding:
      position: 101
      prefix: --card
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: input directory of prevalence data
    inputBinding:
      position: 101
      prefix: --input_directory
  - id: k
    type: int
    doc: k-mer size (e.g., 61)
    inputBinding:
      position: 101
      prefix: -k
  - id: skip
    type:
      - 'null'
      - boolean
    doc: skips the concatenation and splitting of the CARD*R*V sequences.
    inputBinding:
      position: 101
      prefix: --skip
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to use (default=1)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: kmer_files
    type:
      type: array
      items: File
    doc: k-mer database files written in the working directory
    outputBinding:
      glob:
        - '*mer_database.json'
        - '*_kmers.txt'
        - '*mer_*.json'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
