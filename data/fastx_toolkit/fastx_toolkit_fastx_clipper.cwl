cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_clipper
label: fastx_toolkit_fastx_clipper
doc: "Remove adapter sequences from a FASTA/Q file.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: adapter
    type:
      - 'null'
      - string
    doc: "ADAPTER string. Default is CCTTAAGG (dummy adapter)."
    inputBinding:
      position: 101
      prefix: -a
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: "Compress output with GZIP."
    inputBinding:
      position: 101
      prefix: -z
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "DEBUG output."
    inputBinding:
      position: 101
      prefix: -D
  - id: discard_clipped
    type:
      - 'null'
      - boolean
    doc: "Discard clipped sequences (i.e. keep only sequences which did not contain the adapter)."
    inputBinding:
      position: 101
      prefix: -C
  - id: discard_non_clipped
    type:
      - 'null'
      - boolean
    doc: "Discard non-clipped sequences (i.e. keep only sequences which contained the adapter)."
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type:
      - 'null'
      - File
    doc: "FASTA/Q input file. Default is STDIN."
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_after_adapter
    type:
      - 'null'
      - int
    doc: "Keep the adapter and N bases after it. Using '-d 0' is the same as not using '-d' at all, which is the default."
    inputBinding:
      position: 101
      prefix: -d
  - id: keep_n
    type:
      - 'null'
      - boolean
    doc: "Keep sequences with unknown (N) nucleotides. Default is to discard such sequences."
    inputBinding:
      position: 101
      prefix: -n
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: "Require minimum adapter alignment length of N. If fewer than N nucleotides aligned with the adapter, do not clip it."
    inputBinding:
      position: 101
      prefix: -M
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Discard sequences shorter than N nucleotides. Default is 5."
    inputBinding:
      position: 101
      prefix: -l
  - id: output_file_path
    type: string
    doc: "Output or path parameter `output_file_path`"
    inputBinding:
      position: 102
      prefix: -o
  - id: report_adapter_only
    type:
      - 'null'
      - boolean
    doc: "Report Adapter-Only sequences."
    inputBinding:
      position: 101
      prefix: -k
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
    doc: "FASTA/Q output file. Default is STDOUT."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
