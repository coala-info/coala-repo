cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_trimmer
label: fastx_toolkit_fastx_trimmer
doc: "The FASTX-Toolkit Fastx Trimmer is used to shorten sequences in a FASTA or FASTQ
  file (trimming bases from the beginning or end of the sequences).\n\nTool homepage:
  https://github.com/agordon/fastx_toolkit"
inputs:
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: Compress output with GZIP.
    inputBinding:
      position: 101
      prefix: -z
  - id: first_base
    type:
      - 'null'
      - int
    doc: First base to keep. Default is 1 (=first base).
    inputBinding:
      position: 101
      prefix: -f
  - id: input_file
    type:
      - 'null'
      - File
    doc: FASTA/Q input file. default is STDIN.
    inputBinding:
      position: 101
      prefix: -i
  - id: last_base
    type:
      - 'null'
      - int
    doc: Last base to keep. Default is entire read.
    inputBinding:
      position: 101
      prefix: -l
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose - report number of sequences.
    inputBinding:
      position: 101
      prefix: -v
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
