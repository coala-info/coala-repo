cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxrecode]
label: phyx_pxrecode
doc: |-
  Nucleotide sequence recoding.
  This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input sequence file (fasta, fastq, phylip or nexus)"
    inputBinding:
      prefix: -s
  - id: recode
    type: ['null', string]
    doc: "string identifying recoding scheme (default: RY); supported: R = A|G, Y = C|T, S = C|G, W = A|T, M = A|C, K = G|T, B = C|G|T, D = A|G|T, H = A|C|T, V = A|C|G (use any valid combination)"
    inputBinding:
      prefix: -r
  - id: out_file_path
    type: string
    doc: "output sequence file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "recoded sequences (fasta)"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
