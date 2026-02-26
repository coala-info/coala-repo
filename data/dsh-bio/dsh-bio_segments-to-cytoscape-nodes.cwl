cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-segments-to-cytoscape-nodes
label: dsh-bio_segments-to-cytoscape-nodes
doc: "Converts GFA graph segments to Cytoscape nodes.txt format.\n\nTool homepage:
  https://github.com/heuermh/dishevelled-bio"
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
    doc: output Cytoscape nodes.txt format file, default stdout
    outputBinding:
      glob: $(inputs.output_nodes_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
