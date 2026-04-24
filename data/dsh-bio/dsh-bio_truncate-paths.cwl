cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-truncate-paths
label: dsh-bio_truncate-paths
doc: "Truncates paths in a GFA file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
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
    doc: input GFA 1.0 path
    inputBinding:
      position: 101
      prefix: --input-gfa1-path
outputs:
  - id: output_gfa1_file
    type:
      - 'null'
      - File
    doc: output GFA 1.0 file
    outputBinding:
      glob: $(inputs.output_gfa1_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
