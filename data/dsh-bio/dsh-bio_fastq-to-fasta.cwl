cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fastq-to-fasta
label: dsh-bio_fastq-to-fasta
doc: "Converts FASTQ format to FASTA format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
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
  - id: output_fasta_file_path
    type: string
    doc: Output or path parameter `output_fasta_file_path`
    inputBinding:
      position: 102
      prefix: --output-fasta-file
outputs:
  - id: output_fasta_file
    type:
      - 'null'
      - File
    doc: output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
