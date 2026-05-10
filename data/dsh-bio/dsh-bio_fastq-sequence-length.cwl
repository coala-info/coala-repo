cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fastq-sequence-length
label: dsh-bio_fastq-sequence-length
doc: "Calculates the sequence length for each read in a FASTQ file.\n\nTool homepage:
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
  - id: fastq_path
    type:
      - 'null'
      - File
    doc: input FASTQ path
    inputBinding:
      position: 101
      prefix: --fastq-path
  - id: sequence_length_file_path
    type: string
    doc: Output or path parameter `sequence_length_file_path`
    inputBinding:
      position: 102
      prefix: --sequence-length-file
outputs:
  - id: sequence_length_file
    type:
      - 'null'
      - File
    doc: output file of sequence lengths
    outputBinding:
      glob: $(inputs.sequence_length_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
