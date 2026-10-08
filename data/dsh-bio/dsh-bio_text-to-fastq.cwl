cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-text-to-fastq
label: dsh-bio_text-to-fastq
doc: "Converts a text file to a FASTQ file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_text_path
    type:
      - 'null'
      - File
    doc: input text path
    inputBinding:
      position: 101
      prefix: --input-text-path
  - id: output_fastq_file_path
    type: string
    doc: output FASTQ file, default stdout [optional]
    inputBinding:
      position: 102
      prefix: --output-fastq-file
outputs:
  - id: output_fastq_file
    type:
      - 'null'
      - File
    doc: output FASTQ file
    outputBinding:
      glob: $(inputs.output_fastq_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
