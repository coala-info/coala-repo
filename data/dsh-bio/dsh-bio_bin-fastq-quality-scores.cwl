cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bin-fastq-quality-scores
label: dsh-bio_bin-fastq-quality-scores
doc: "Calculate quality scores for FASTQ files.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fastq_path
    type:
      - 'null'
      - File
    doc: input FASTQ path
    inputBinding:
      position: 101
      prefix: --input-fastq-path
  - id: output_fastq_file_path
    type: string
    doc: Output or path parameter `output_fastq_file_path`
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
