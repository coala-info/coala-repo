cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_collapser
label: fastx_toolkit_fastx_collapser
doc: "Collapses identical sequences in a FASTA/Q file into a single sequence.\n\n
  Tool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: FASTA/Q input file. default is STDIN.
    inputBinding:
      position: 101
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'verbose: report number of sequences. If [-o] is specified, report will be
      printed to STDOUT. If [-o] is not specified (and output goes to STDOUT), report
      will be printed to STDERR.'
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
