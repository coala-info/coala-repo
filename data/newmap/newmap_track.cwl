cwlVersion: v1.2
class: CommandLineTool
baseCommand: newmap_track
label: newmap_track
doc: "Calculate mappability values based on read length and unique count files.\n\n\
  Tool homepage: https://github.com/hoffmangroup/newmap"
inputs:
  - id: read_length
    type:
      - 'null'
      - int
    doc: Mappability values to be calculated based on this read length.
    inputBinding:
      position: 1
  - id: unique_count_files
    type:
      type: array
      items: File
    doc: One or more unique count files to convert to mappability files
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional information to standard error
    inputBinding:
      position: 103
      prefix: --verbose
  - id: multi_read_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `multi_read_path`
    inputBinding:
      position: 104
      prefix: --multi-read
  - id: single_read_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `single_read_path`
    inputBinding:
      position: 105
      prefix: --single-read
outputs:
  - id: single_read
    type:
      - 'null'
      - File
    doc: Filename for single-read mappability BED file output. Use '-' for 
      standard output.
    outputBinding:
      glob: $(inputs.single_read_path)
  - id: multi_read
    type:
      - 'null'
      - File
    doc: Filename for multi-read mappability WIG file output. Use '-' for 
      standard output.
    outputBinding:
      glob: $(inputs.multi_read_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newmap:0.2--py312h9c9b0c2_1
