cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_uncollapser
label: fastx_toolkit_fastx_uncollapser
doc: "Restore sequences collapsed by fastx_collapser: expand each collapsed identifier (e.g. '1-1000') back into its repeated sequences. Also works on a tabular file.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: collapsed_id_column
    type:
      - 'null'
      - int
    doc: "Assume input is a tabular file (not a FASTA file), and the collapsed identifier (e.g. '1-1000') is on column N."
    inputBinding:
      position: 101
      prefix: -c
  - id: input_file
    type:
      - 'null'
      - File
    doc: "FASTA/Tabular input file. Default is STDIN."
    inputBinding:
      position: 101
      prefix: -i
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
    doc: "Verbose: print short summary of input/output counts."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "FASTA/Tabular output file. Default is STDOUT."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
