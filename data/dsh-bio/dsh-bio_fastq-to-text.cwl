cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fastq-to-text
label: dsh-bio_fastq-to-text
doc: "Converts FASTQ files to a text format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_fastq_path
    type:
      - 'null'
      - File
    doc: input FASTQ path
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-fastq-path
outputs:
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: output text file
    outputBinding:
      glob: $(inputs.output_text_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
