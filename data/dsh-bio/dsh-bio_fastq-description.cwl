cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-fastq-description
label: dsh-bio_fastq-description
doc: "Display description lines from a FASTQ file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
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
outputs:
  - id: description_file
    type:
      - 'null'
      - File
    doc: output file of description lines
    outputBinding:
      glob: $(inputs.description_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
