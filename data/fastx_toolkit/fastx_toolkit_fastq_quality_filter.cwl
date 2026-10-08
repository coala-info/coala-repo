cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_quality_filter
label: fastx_toolkit_fastq_quality_filter
doc: "Filter FASTQ reads by quality: keep reads where at least a given percent of bases reach a minimum quality score.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: ascii_offset
    type:
      - 'null'
      - int
    doc: "FASTQ ASCII offset. Default is 33."
    inputBinding:
      position: 101
      prefix: -Q
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: "Compress output with GZIP."
    inputBinding:
      position: 101
      prefix: -z
  - id: input_file
    type:
      - 'null'
      - File
    doc: "FASTQ input file. Default is STDIN."
    inputBinding:
      position: 101
      prefix: -i
  - id: min_percent
    type:
      - 'null'
      - int
    doc: "Minimum percent of bases that must have [-q] quality."
    inputBinding:
      position: 101
      prefix: -p
  - id: min_quality
    type:
      - 'null'
      - int
    doc: "Minimum quality score to keep."
    inputBinding:
      position: 101
      prefix: -q
  - id: output_file_path
    type: string
    doc: "Output or path parameter `output_file_path`"
    inputBinding:
      position: 102
      prefix: -o
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose - report number of sequences. If [-o] is specified, report will be printed to STDOUT. If [-o] is not specified (and output goes to STDOUT), report will be printed to STDERR."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "FASTQ output file. Default is STDOUT."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
