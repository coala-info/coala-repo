cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastani
label: fastani
doc: "Fast Whole-Genome Similarity (ANI) estimation. FastANI is a fast alignment-free
  implementation for computing whole-genome Average Nucleotide Identity (ANI).\n\n
  Tool homepage: https://github.com/ParBLiSS/FastANI"
inputs:
  - id: frag_len
    type:
      - 'null'
      - int
    doc: Fragment length
    inputBinding:
      position: 101
      prefix: --fragLen
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size <= 16
    inputBinding:
      position: 101
      prefix: --kmer
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction of genome that must be shared for trusting ANI
    inputBinding:
      position: 101
      prefix: --minFraction
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query genome file
    inputBinding:
      position: 101
      prefix: --query
  - id: query_list
    type:
      - 'null'
      - File
    doc: File containing list of query genome files
    inputBinding:
      position: 101
      prefix: --ql
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference genome file
    inputBinding:
      position: 101
      prefix: --ref
  - id: reference_list
    type:
      - 'null'
      - File
    doc: File containing list of reference genome files
    inputBinding:
      position: 101
      prefix: --rl
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count for parallel execution
    inputBinding:
      position: 101
      prefix: --threads
  - id: visualize
    type:
      - 'null'
      - boolean
    doc: Output mappings for visualization, can be used for only one-to-one genome
      comparison
    inputBinding:
      position: 101
      prefix: --visualize
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastani:1.34--h4dfc31f_4
