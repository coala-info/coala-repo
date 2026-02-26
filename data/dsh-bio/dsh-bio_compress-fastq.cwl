cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-fastq
label: dsh-bio_compress-fastq
doc: "Compresses FASTQ files.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
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
