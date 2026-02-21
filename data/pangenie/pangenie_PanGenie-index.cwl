cwlVersion: v1.2
class: CommandLineTool
baseCommand: PanGenie-index
label: pangenie_PanGenie-index
doc: "PanGenie - genotyping based on kmer-counting and known haplotype sequences.
  Indexing step.\n\nTool homepage: https://github.com/eblerjana/pangenie"
inputs:
  - id: hash_size
    type:
      - 'null'
      - int
    doc: size of hash used by jellyfish
    default: 3000000000
    inputBinding:
      position: 101
      prefix: -e
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size
    default: 31
    inputBinding:
      position: 101
      prefix: -k
  - id: reference_genome
    type: File
    doc: 'reference genome in FASTA format. NOTE: INPUT FASTA FILE MUST NOT BE COMPRESSED.'
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for kmer-counting
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: variants
    type: File
    doc: 'variants in VCF format. NOTE: INPUT VCF FILE MUST NOT BE COMPRESSED.'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_prefix
    type: File
    doc: 'prefix of the output files. NOTE: the given path must not include non-existent
      folders.'
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangenie:4.2.1--h077b44d_0
