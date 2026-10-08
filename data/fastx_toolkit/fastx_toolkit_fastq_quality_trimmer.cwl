cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_quality_trimmer
label: fastx_toolkit_fastq_quality_trimmer
doc: "Trim low-quality ends of reads in a FASTQ file, and discard reads that are too short after trimming.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
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
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length - sequences shorter than this (after trimming) will be discarded. Default = 0 = no minimum length."
    inputBinding:
      position: 101
      prefix: -l
  - id: output_file_path
    type: string
    doc: "Output or path parameter `output_file_path`"
    inputBinding:
      position: 102
      prefix: -o
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: "Quality threshold - nucleotides with lower quality will be trimmed (from the end of the sequence)."
    inputBinding:
      position: 101
      prefix: -t
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
