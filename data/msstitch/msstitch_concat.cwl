cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msstitch
  - concat
label: msstitch_concat
doc: "Concatenates multiple msstitch files.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Multiple input files of {} format
    inputBinding:
      position: 1
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Directory to output in
    inputBinding:
      position: 102
      prefix: -d
  - id: output_file_path
    type: string?
    doc: Output file
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
