cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-downsample-fastq
label: dsh-bio_downsample-fastq
doc: "Downsample FASTQ files\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fastq_path
    type:
      - 'null'
      - File
    doc: input FASTQ path, default stdin
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-fastq-path
  - id: probability
    type: float
    doc: probability a FASTQ record will be removed, [0.0-1.0]
    inputBinding:
      position: 101
      prefix: --probability
  - id: seed
    type:
      - 'null'
      - int
    doc: random number seed, default relates to current time
    default: relates to current time
    inputBinding:
      position: 101
      prefix: --seed
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
