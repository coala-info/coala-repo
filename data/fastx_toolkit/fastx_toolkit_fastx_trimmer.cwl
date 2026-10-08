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
  - id: trim_end
    type:
      - 'null'
      - int
    doc: Trim N nucleotides from the end of the read. Cannot be used with -l and -f.
    inputBinding:
      position: 101
      prefix: -t
  - id: min_length
    type:
      - 'null'
      - int
    doc: With -t, discard reads shorter than MINLEN.
    inputBinding:
      position: 101
      prefix: -m
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: FASTA/Q output file. default is STDOUT.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
