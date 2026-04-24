cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qimba
  - make-mapping
label: qimba_make-mapping
doc: "Generate a sample mapping file from a directory of sequence files.\n\nTool homepage:
  https://github.com/quadram-institute-bioscience/qimba"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing sequence files
    inputBinding:
      position: 1
  - id: absolute_paths
    type:
      - 'null'
      - boolean
    doc: Use absolute paths in output
    inputBinding:
      position: 102
      prefix: --absolute
  - id: dont_rename
    type:
      - 'null'
      - boolean
    doc: Do not remove illegal chars from SampleIDs
    inputBinding:
      position: 102
      prefix: --dont-rename
  - id: file_extension
    type:
      - 'null'
      - string
    doc: File extension to look for
    inputBinding:
      position: 102
      prefix: --ext
  - id: forward_read_tag
    type:
      - 'null'
      - string
    doc: Forward read tag
    inputBinding:
      position: 102
      prefix: --tag-for
  - id: reverse_read_tag
    type:
      - 'null'
      - string
    doc: Reverse read tag
    inputBinding:
      position: 102
      prefix: --tag-rev
  - id: safe_char
    type:
      - 'null'
      - string
    doc: Safe character for sample names
    inputBinding:
      position: 102
      prefix: --safe-char
  - id: strip_string
    type:
      - 'null'
      - string
    doc: Additional string to strip from filenames
    inputBinding:
      position: 102
      prefix: --strip
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output mapping file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
