cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-links-to-cytoscape-edges
label: dsh-bio_links-to-cytoscape-edges
doc: "Converts GFA graph to Cytoscape edge list format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
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
  - id: output_edges_file
    type:
      - 'null'
      - File
    doc: output Cytoscape edges.txt format file, default stdout
    outputBinding:
      glob: $(inputs.output_edges_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
