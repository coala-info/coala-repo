cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-rgfa
label: dsh-bio_compress-rgfa
doc: "Compresses an rGFA file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_rgfa_path
    type:
      - 'null'
      - File
    doc: input rGFA path
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-rgfa-path
outputs:
  - id: output_rgfa_file
    type:
      - 'null'
      - File
    doc: output rGFA file
    outputBinding:
      glob: $(inputs.output_rgfa_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
