cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_quality_converter
label: fastx_toolkit_fastq_quality_converter
doc: "Converts FASTQ quality scores from ASCII to numeric (or vice versa). Part of
  the FASTX Toolkit.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: ascii_scores
    type:
      - 'null'
      - boolean
    doc: Output ASCII quality scores (default).
    inputBinding:
      position: 101
      prefix: -a
  - id: compress_gzip
    type:
      - 'null'
      - boolean
    doc: Compress output with GZIP.
    inputBinding:
      position: 101
      prefix: -z
  - id: input_file
    type:
      - 'null'
      - File
    doc: FASTA/Q input file. default is STDIN.
    inputBinding:
      position: 101
      prefix: -i
  - id: numeric_scores
    type:
      - 'null'
      - boolean
    doc: Output numeric quality scores.
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: FASTA/Q output file. default is STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
