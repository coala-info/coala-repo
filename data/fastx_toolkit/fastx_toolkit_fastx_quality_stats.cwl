cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_quality_stats
label: fastx_toolkit_fastx_quality_stats
doc: "Calculate per-column (cycle) quality statistics of a FASTQ file: counts, min, max, mean, quartiles, whiskers and nucleotide counts.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: ascii_offset
    type:
      - 'null'
      - int
    doc: "FASTQ ASCII offset. Default is 33."
    inputBinding:
      position: 101
      prefix: -Q
  - id: input_file
    type:
      - 'null'
      - File
    doc: "FASTQ input file. Default is STDIN."
    inputBinding:
      position: 101
      prefix: -i
  - id: new_format
    type:
      - 'null'
      - boolean
    doc: "New output format (with more information per nucleotide/cycle)."
    inputBinding:
      position: 101
      prefix: -N
  - id: output_file_path
    type: string
    doc: "Output or path parameter `output_file_path`"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Text output file. Default is STDOUT."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
