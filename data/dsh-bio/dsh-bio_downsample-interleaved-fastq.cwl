cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-downsample-interleaved-fastq
label: dsh-bio_downsample-interleaved-fastq
doc: "Downsample interleaved FASTQ files\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fastq_path
    type:
      - 'null'
      - File
    doc: input interleaved FASTQ path, default stdin
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
    inputBinding:
      position: 101
      prefix: --seed
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
    doc: output interleaved FASTQ file, default stdout
    outputBinding:
      glob: $(inputs.output_fastq_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
