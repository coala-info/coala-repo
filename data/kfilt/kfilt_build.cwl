cwlVersion: v1.2
class: CommandLineTool
baseCommand: kfilt build
label: kfilt_build
doc: "Build a fast hybrid index (Bloom filter + hash table + BK-tree) for efficient
  k-mer matching\n\nTool homepage: https://github.com/davidebolo1993/kfilt"
inputs:
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size
    default: 31
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: kmers
    type:
      - 'null'
      - string
    doc: Input k-mer file (meryl print output)
    inputBinding:
      position: 101
      prefix: --kmers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output index file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kfilt:0.1.1--he881be0_0
