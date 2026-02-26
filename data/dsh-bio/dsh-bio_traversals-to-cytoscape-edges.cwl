cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-traversals-to-cytoscape-edges
label: dsh-bio_traversals-to-cytoscape-edges
doc: "Converts traversals from a GFA file to Cytoscape edge list format.\n\nTool homepage:
  https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_gfa1_path
    type: File
    doc: input GFA 1.0 path, default stdin
    inputBinding:
      position: 101
      prefix: --input-gfa1-path
outputs:
  - id: output_edges_file
    type: File
    doc: output Cytoscape edges.txt format file, default stdout
    outputBinding:
      glob: $(inputs.output_edges_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
