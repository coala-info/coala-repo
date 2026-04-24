cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmer-counter
label: kmer-counter
doc: "Tally nucleotide counts in multi-entry fasta\n\nTool homepage: https://github.com/CobiontID/kmer-counter"
inputs:
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: Canonicalize k-mers (default 1 = True
    inputBinding:
      position: 101
      prefix: --collapse
  - id: file
    type: File
    doc: Fasta file to tally.
    inputBinding:
      position: 101
      prefix: --file
  - id: ids
    type:
      - 'null'
      - File
    doc: File to write identifiers to
    inputBinding:
      position: 101
      prefix: --ids
  - id: klength
    type:
      - 'null'
      - int
    doc: K-mer length
    inputBinding:
      position: 101
      prefix: --klength
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmer-counter:0.1.2--h4349ce8_0
