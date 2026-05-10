cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-interleave-fastq
label: dsh-bio_interleave-fastq
doc: "Interleaves two FASTQ files into a single paired FASTQ file, with unpaired reads
  written to a separate file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: first_fastq_path
    type: File
    doc: first FASTQ input path
    inputBinding:
      position: 101
      prefix: --first-fastq-path
  - id: second_fastq_path
    type: File
    doc: second FASTQ input path
    inputBinding:
      position: 101
      prefix: --second-fastq-path
  - id: paired_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `paired_file_path`
    inputBinding:
      position: 102
      prefix: --paired-file
  - id: unpaired_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `unpaired_file_path`
    inputBinding:
      position: 103
      prefix: --unpaired-file
outputs:
  - id: paired_file
    type: File
    doc: output interleaved paired FASTQ file
    outputBinding:
      glob: $(inputs.paired_file_path)
  - id: unpaired_file
    type: File
    doc: output unpaired FASTQ file
    outputBinding:
      glob: $(inputs.unpaired_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
