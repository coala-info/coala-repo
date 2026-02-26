cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoblaster
label: nanoblaster
doc: "NanoBLASTer is a tool for rapid and accurate alignment of long sequencing reads.\n\
  \nTool homepage: https://github.com/ruhulsbu/NanoBLASTer"
inputs:
  - id: anchor_size
    type:
      - 'null'
      - int
    doc: To specify the size of ANCHOR
    inputBinding:
      position: 101
      prefix: -a
  - id: gap_length
    type:
      - 'null'
      - int
    doc: To specify the interval (or Gap) length between KMERs
    inputBinding:
      position: 101
      prefix: -g
  - id: high_sensitive_mode
    type:
      - 'null'
      - boolean
    doc: To run the program in high sensitive mode
    inputBinding:
      position: 101
      prefix: -s
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: To specify the size of KMER
    inputBinding:
      position: 101
      prefix: -k
  - id: less_memory_single_index
    type:
      - 'null'
      - boolean
    doc: To configure NanoBLASTer for less memory using Single index
    inputBinding:
      position: 101
      prefix: -X
  - id: min_clusters
    type:
      - 'null'
      - int
    doc: To specify the min number of Clusters
    inputBinding:
      position: 101
      prefix: -l
  - id: num_reads_to_align
    type:
      - 'null'
      - int
    doc: To specify the Number of reads to be aligned
    inputBinding:
      position: 101
      prefix: -n
  - id: parameter_c
    type:
      - 'null'
      - string
    doc: 'To specify one of the Parameters: -C10, -C25, or -C50'
    inputBinding:
      position: 101
      prefix: -C
  - id: reads_file
    type: File
    doc: To specify the name of Reads file
    inputBinding:
      position: 101
      prefix: -i
  - id: reference_file
    type: File
    doc: To specify the name of Reference file
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: To specify the prefix of Output file
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoblaster:0.16--h9948957_8
