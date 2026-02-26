cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-traversals-to-property-graph
label: dsh-bio_traversals-to-property-graph
doc: "Converts GFA traversals to a property graph format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_gfa1_path
    type:
      - 'null'
      - File
    doc: input GFA 1.0 path, default stdin
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-gfa1-path
outputs:
  - id: output_edges_file
    type:
      - 'null'
      - File
    doc: output property graph CSV format file, default stdout
    outputBinding:
      glob: $(inputs.output_edges_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
