cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsift
label: samsift
doc: "advanced filtering and tagging of SAM/BAM alignments using Python expressions\n\
  \nTool homepage: https://github.com/karel-brinda/samsift"
inputs:
  - id: code_to_execute
    type:
      - 'null'
      - type: array
        items: string
    doc: code to be executed (e.g., assigning new tags)
    inputBinding:
      position: 101
      prefix: -c
  - id: debugging_expression
    type:
      - 'null'
      - type: array
        items: string
    doc: debugging expression to print
    inputBinding:
      position: 101
      prefix: -d
  - id: debugging_trigger
    type:
      - 'null'
      - type: array
        items: string
    doc: debugging trigger
    inputBinding:
      position: 101
      prefix: -t
  - id: filtering_expression
    type:
      - 'null'
      - type: array
        items: string
    doc: filtering expression
    inputBinding:
      position: 101
      prefix: -f
  - id: initialization
    type:
      - 'null'
      - type: array
        items: string
    doc: initialization
    inputBinding:
      position: 101
      prefix: '-0'
  - id: input_file
    type:
      - 'null'
      - File
    doc: input SAM/BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: mode
    type:
      - 'null'
      - string
    doc: "mode: strict (stop on first error)\n                          nonstop-keep
      (keep alignments causing errors)\n                          nonstop-remove (remove
      alignments causing errors)"
    inputBinding:
      position: 101
      prefix: -m
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output SAM/BAM file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsift:0.3.1--pyhdfd78af_0
