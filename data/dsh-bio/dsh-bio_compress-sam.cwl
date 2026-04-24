cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-sam
label: dsh-bio_compress-sam
doc: "Compresses a SAM file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_sam_path
    type:
      - 'null'
      - File
    doc: input SAM path, default stdin
    inputBinding:
      position: 101
      prefix: --input-sam-path
outputs:
  - id: output_sam_file
    type:
      - 'null'
      - File
    doc: output SAM file, default stdout
    outputBinding:
      glob: $(inputs.output_sam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
