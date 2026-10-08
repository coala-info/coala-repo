cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-disinterleave-fastq
label: dsh-bio_disinterleave-fastq
doc: "Disinterleaves a FASTQ file into paired and unpaired files.\n\nTool homepage:
  https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: first_fastq_file_path
    type: string
    doc: first FASTQ output file
    inputBinding:
      position: 101
      prefix: --first-fastq-file
  - id: paired_path
    type: File
    doc: interleaved paired FASTQ input path
    inputBinding:
      position: 101
      prefix: --paired-path
  - id: second_fastq_file_path
    type: string
    doc: second FASTQ output file
    inputBinding:
      position: 101
      prefix: --second-fastq-file
  - id: unpaired_path
    type:
      - 'null'
      - File
    doc: unpaired FASTQ input path
    inputBinding:
      position: 101
      prefix: --unpaired-path
outputs:
  - id: first_fastq_file
    type: File
    doc: first FASTQ output file
    outputBinding:
      glob: $(inputs.first_fastq_file_path)
  - id: second_fastq_file
    type: File
    doc: second FASTQ output file
    outputBinding:
      glob: $(inputs.second_fastq_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
