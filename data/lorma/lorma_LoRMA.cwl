cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorma_LoRMA
label: lorma_LoRMA
doc: "LoRMA options\n\nTool homepage: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/"
inputs:
  - id: bestfriends
    type:
      - 'null'
      - int
    doc: Number of best friends
    inputBinding:
      position: 101
      prefix: -bestfriends
  - id: friends
    type:
      - 'null'
      - int
    doc: Number of friends
    inputBinding:
      position: 101
      prefix: -friends
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: kmer length
    inputBinding:
      position: 101
      prefix: -k
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores
    inputBinding:
      position: 101
      prefix: -nb-cores
  - id: reads_files
    type:
      type: array
      items: File
    doc: file(s) of long reads
    inputBinding:
      position: 101
      prefix: -reads
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: verbosity level
    inputBinding:
      position: 101
      prefix: -verbose
  - id: discarded_reads_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `discarded_reads_file_path`
    inputBinding:
      position: 102
      prefix: --discarded-reads-file
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: discarded_reads_file
    type: File
    doc: output file for discarded reads
    outputBinding:
      glob: $(inputs.discarded_reads_file_path)
  - id: output_file
    type: File
    doc: output file for corrected reads
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorma:0.4--2
