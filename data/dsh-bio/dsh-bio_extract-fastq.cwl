cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-extract-fastq
label: dsh-bio_extract-fastq
doc: "Extracts sequences from a FASTQ file based on name or description.\n\nTool homepage:
  https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: description
    type:
      - 'null'
      - string
    doc: FASTQ description regex pattern to match
    inputBinding:
      position: 101
      prefix: --description
  - id: input_fastq_path
    type:
      - 'null'
      - File
    doc: input FASTQ path
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-fastq-path
  - id: name
    type:
      - 'null'
      - string
    doc: exact sequence name to match
    inputBinding:
      position: 101
      prefix: --name
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
