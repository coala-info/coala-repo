cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeBloom
label: fastqpuri_makeBloom
doc: "makeBloom from FastqPuri\n\nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs:
  - id: bfsizeBits
    type:
      - 'null'
      - int
    doc: size of the filter in bits. It will be forced to be a multiple of 8.
    inputBinding:
      position: 101
      prefix: --bfsizeBits
  - id: fal_pos_rate
    type:
      - 'null'
      - float
    doc: false positive rate.
    inputBinding:
      position: 101
      prefix: --fal_pos_rate
  - id: fasta_input
    type: File
    doc: Fasta input file.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: hashNum
    type:
      - 'null'
      - int
    doc: number of hash functions used.
    inputBinding:
      position: 101
      prefix: --hashNum
  - id: kmersize
    type:
      - 'null'
      - int
    doc: kmer size, number or elements.
    inputBinding:
      position: 101
      prefix: --kmersize
  - id: output
    type: string
    doc: Output file, with NO extension.
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
stdout: fastqpuri_makeBloom.out
