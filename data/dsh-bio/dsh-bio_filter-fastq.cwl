cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-fastq
label: dsh-bio_filter-fastq
doc: "Filter FASTQ files based on various criteria.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fastq_path
    type:
      - 'null'
      - File
    doc: input FASTQ path, default stdin
    inputBinding:
      position: 101
      prefix: --input-fastq-path
  - id: length
    type:
      - 'null'
      - int
    doc: filter by length
    inputBinding:
      position: 101
      prefix: --length
  - id: script
    type:
      - 'null'
      - string
    doc: filter by script, eval against r
    inputBinding:
      position: 101
      prefix: --script
outputs:
  - id: output_fastq_file
    type:
      - 'null'
      - File
    doc: output FASTQ file, default stdout
    outputBinding:
      glob: $(inputs.output_fastq_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
