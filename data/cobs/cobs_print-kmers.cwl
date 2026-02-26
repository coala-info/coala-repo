cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cobs
  - print-kmers
label: cobs_print-kmers
doc: "Prints all k-mers of a given DNA sequence.\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: query
    type: string
    doc: the dna sequence to search for
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: the size of one kmer
    default: 31
    inputBinding:
      position: 102
      prefix: --kmer-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
stdout: cobs_print-kmers.out
