cwlVersion: v1.2
class: CommandLineTool
baseCommand: format_reads
label: methpipe_format_reads
doc: "convert SAM/BAM mapped bs-seq reads to standard methpipe format\n\nTool homepage:
  https://github.com/smithlabcode/methpipe"
inputs:
  - id: input_file
    type: File
    doc: input SAM/BAM file
    inputBinding:
      position: 1
  - id: about
    type:
      - 'null'
      - boolean
    doc: print about message
    inputBinding:
      position: 102
      prefix: -about
  - id: format
    type:
      - 'null'
      - string
    doc: input format (abismal, bsmap, bismark)
    inputBinding:
      position: 102
      prefix: -format
  - id: max_buffer_size
    type:
      - 'null'
      - int
    doc: maximum buffer size
    default: 10000
    inputBinding:
      position: 102
      prefix: -buf-size
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: maximum allowed insert size
    default: 10000
    inputBinding:
      position: 102
      prefix: -max-frag
  - id: read_name_suffix_length
    type:
      - 'null'
      - int
    doc: read name suffix length
    default: 1
    inputBinding:
      position: 102
      prefix: -suff
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print more information
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
