cwlVersion: v1.2
class: CommandLineTool
baseCommand: rotate
label: rotate
doc: "Rotate a FASTA file to a new start position.\n\nTool homepage: https://github.com/richarddurbin/rotate"
inputs:
  - id: input_fasta_filename
    type: File
    doc: input fasta filename
    inputBinding:
      position: 1
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: maximum number of mismatches allowed in search
    inputBinding:
      position: 102
      prefix: -m
  - id: new_start_position
    type:
      - 'null'
      - int
    doc: position to become new start
    inputBinding:
      position: 102
      prefix: -x
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: reverse complement after rotating
    inputBinding:
      position: 102
      prefix: -rc
  - id: search_string
    type:
      - 'null'
      - string
    doc: rotate to start of search string
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rotate:1.0--h577a1d6_1
