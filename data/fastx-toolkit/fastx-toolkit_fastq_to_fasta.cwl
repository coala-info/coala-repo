cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq_to_fasta
label: fastx-toolkit_fastq_to_fasta
doc: "Convert FASTQ files to FASTA files.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
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
    doc: FASTQ input file. Default is STDIN.
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_n
    type:
      - 'null'
      - boolean
    doc: Keep sequences with unknown (N) nucleotides. Default is to discard such sequences.
    inputBinding:
      position: 101
      prefix: -n
  - id: rename_identifiers
    type:
      - 'null'
      - boolean
    doc: Rename sequence identifiers to numbers.
    inputBinding:
      position: 101
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose - report number of sequences. If [-o] is specified, report will be
      printed to STDOUT. If [-o] is not specified, report will be printed to STDERR.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: FASTA output file. Default is STDOUT.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
