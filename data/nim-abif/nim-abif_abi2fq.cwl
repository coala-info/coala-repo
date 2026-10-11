cwlVersion: v1.2
class: CommandLineTool
baseCommand: abi2fq
label: nim-abif_abi2fq
doc: "Convert ABI files to FASTQ with quality trimming\n\nTool homepage: https://github.com/quadram-institute-bioscience/nim-abif"
inputs:
  - id: input_file
    type: File
    doc: Input ABI file
    inputBinding:
      position: 1
  - id: output_fastq
    type:
      - 'null'
      - string
    doc: Output FASTQ file name (FASTQ is written to standard output when not given)
    inputBinding:
      position: 2
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Disable quality trimming
    inputBinding:
      position: 102
      prefix: --no-trim
  - id: quality
    type:
      - 'null'
      - int
    doc: Quality threshold 0-60
    inputBinding:
      position: 102
      prefix: --quality
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional information
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for quality trimming
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: fastq_stdout
    type: stdout
    doc: FASTQ written to standard output (empty when output_fastq is given)
  - id: output_fastq_file
    type:
      - 'null'
      - File
    doc: Output FASTQ file
    outputBinding:
      glob: $(inputs.output_fastq)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
stdout: nim-abif_abi2fq.fastq
