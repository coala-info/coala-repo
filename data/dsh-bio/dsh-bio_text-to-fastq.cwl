cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-text-to-fastq
label: dsh-bio_text-to-fastq
doc: "Converts a text file to a FASTQ file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_text_path
    type:
      - 'null'
      - File
    doc: input text path
    inputBinding:
      position: 101
      prefix: --input-text-path
outputs:
  - id: output_fastq_file
    type:
      - 'null'
      - File
    doc: output FASTQ file
    outputBinding:
      glob: $(inputs.output_fastq_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
