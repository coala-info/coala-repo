cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-identify-gfa1
label: dsh-bio_identify-gfa1
doc: "Identify GFA 1.0 files\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
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
  - id: output_gfa1_file
    type:
      - 'null'
      - File
    doc: output GFA 1.0 file, default stdout
    outputBinding:
      glob: $(inputs.output_gfa1_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
