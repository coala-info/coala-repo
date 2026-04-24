cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-gfa1-to-gfa2
label: dsh-bio_gfa1-to-gfa2
doc: "Converts GFA 1.0 format to GFA 2.0 format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_gfa1_path
    type:
      - 'null'
      - File
    doc: input GFA 1.0 path, default stdin
    inputBinding:
      position: 101
      prefix: --input-gfa1-path
outputs:
  - id: output_gfa2_file
    type:
      - 'null'
      - File
    doc: output GFA 2.0 file, default stdout
    outputBinding:
      glob: $(inputs.output_gfa2_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
