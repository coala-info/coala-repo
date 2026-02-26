cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-paf
label: dsh-bio_compress-paf
doc: "Compresses a PAF file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_paf_path
    type:
      - 'null'
      - File
    doc: input PAF path
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-paf-path
outputs:
  - id: output_paf_file
    type:
      - 'null'
      - File
    doc: output PAF file
    outputBinding:
      glob: $(inputs.output_paf_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
