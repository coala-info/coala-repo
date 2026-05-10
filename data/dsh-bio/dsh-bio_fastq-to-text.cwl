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
    inputBinding:
      position: 101
      prefix: --input-fastq-path
  - id: output_text_file_path
    type: string
    doc: Output or path parameter `output_text_file_path`
    inputBinding:
      position: 102
      prefix: --output-text-file
outputs:
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: output text file
    outputBinding:
      glob: $(inputs.output_text_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
