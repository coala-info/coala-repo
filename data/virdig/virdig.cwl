cwlVersion: v1.2
class: CommandLineTool
baseCommand: virdig
label: virdig
doc: "virdig is a tool for viral genome assembly.\n\nTool homepage: https://github.com/Limh616/VirDiG"
inputs:
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: length of kmer
    inputBinding:
      position: 101
      prefix: -k
  - id: left_reads_file
    type:
      - 'null'
      - File
    doc: left reads file name (.fasta)
    inputBinding:
      position: 101
      prefix: -l
  - id: map_weight
    type:
      - 'null'
      - float
    doc: paired-end reads are assigned paired node weights, recommended to be in
      the range of 0 to 1
    inputBinding:
      position: 101
      prefix: --map_weight
  - id: non_canonical
    type:
      - 'null'
      - int
    doc: 'whether to generate non-standard transcripts, 1 : true, 0 : false'
    inputBinding:
      position: 101
      prefix: --non_canonical
  - id: pair_end_directions
    type:
      - 'null'
      - int
    doc: 'pair-end reads directions can be defined, 1: opposite directions  2: same
      direction'
    inputBinding:
      position: 101
      prefix: -d
  - id: ref_genome_len
    type:
      - 'null'
      - int
    doc: approximate length of the viral reference genome
    inputBinding:
      position: 101
      prefix: --ref_genome_len
  - id: right_reads_file
    type:
      - 'null'
      - File
    doc: right reads file name (.fasta)
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virdig:1.0.0--h5ca1c30_0
