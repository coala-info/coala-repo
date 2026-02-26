cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_reassemble-paths
label: dsh-bio_reassemble-paths
doc: "Reassemble paths from a GFA file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_gfa1_path
    type:
      - 'null'
      - File
    doc: input GFA 1.0 path
    default: stdin
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
