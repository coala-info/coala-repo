cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-segments-to-property-graph
label: dsh-bio_segments-to-property-graph
doc: "Converts GFA files to a property graph format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
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
  - id: output_nodes_file
    type:
      - 'null'
      - File
    doc: output property graph CSV format file, default stdout
    outputBinding:
      glob: $(inputs.output_nodes_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
