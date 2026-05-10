cwlVersion: v1.2
class: CommandLineTool
baseCommand: sff2fastq
label: sff2fastq
doc: "Convert SFF (Standard Flowgram Format) files to FASTQ format.\n\nTool homepage:
  https://github.com/indraniel/sff2fastq"
inputs:
  - id: input_sff
    type: File
    doc: Input SFF file
    inputBinding:
      position: 1
  - id: include_name_in_quality
    type:
      - 'null'
      - boolean
    doc: Include sequence name in the quality line
    inputBinding:
      position: 102
      prefix: -n
  - id: output_fastq_path
    type: string
    doc: Output or path parameter `output_fastq_path`
    inputBinding:
      position: 103
      prefix: --output-fastq
outputs:
  - id: output_fastq
    type:
      - 'null'
      - File
    doc: Output FASTQ file (default is stdout)
    outputBinding:
      glob: $(inputs.output_fastq_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sff2fastq:0.9.2--h470a237_1
