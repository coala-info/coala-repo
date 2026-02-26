cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmerinshort
label: kmerinshort_KmerInShort
doc: "KmerInShort tool\n\nTool homepage: https://github.com/rizkg/KmerInShort"
inputs:
  - id: dont_reverse
    type:
      - 'null'
      - boolean
    doc: do not reverse kmers, count forward and reverse complement separately
    inputBinding:
      position: 101
  - id: freq
    type:
      - 'null'
      - boolean
    doc: output frequency
    inputBinding:
      position: 101
  - id: input_file
    type: File
    doc: input file
    inputBinding:
      position: 101
      prefix: -file
  - id: kmer_size
    type: int
    doc: ksize
    inputBinding:
      position: 101
      prefix: -kmer-size
  - id: kval
    type:
      - 'null'
      - File
    doc: file with kmer values
    default: ''
    inputBinding:
      position: 101
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    default: 0
    inputBinding:
      position: 101
  - id: offset
    type:
      - 'null'
      - int
    doc: starting offset
    default: 0
    inputBinding:
      position: 101
  - id: per_seq
    type:
      - 'null'
      - boolean
    doc: one output file and count per fasta sequence
    inputBinding:
      position: 101
  - id: step
    type:
      - 'null'
      - int
    doc: step
    default: 1
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 1
    inputBinding:
      position: 101
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerinshort:1.0.1--0
