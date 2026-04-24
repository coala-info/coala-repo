cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-extract-fastq-by-length
label: dsh-bio_extract-fastq-by-length
doc: "Extract FASTQ reads by sequence length.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fastq_path
    type:
      - 'null'
      - File
    doc: input FASTQ path, default stdin
    inputBinding:
      position: 101
      prefix: --input-fastq-path
  - id: maximum_length
    type: int
    doc: maximum sequence length, exclusive
    inputBinding:
      position: 101
      prefix: --maximum-length
  - id: minimum_length
    type: int
    doc: minimum sequence length, inclusive
    inputBinding:
      position: 101
      prefix: --minimum-length
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
