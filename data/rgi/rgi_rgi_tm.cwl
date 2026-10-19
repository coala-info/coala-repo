cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - tm
label: rgi_rgi_tm
doc: "Calculates the melting temperature of baits (probes) with melt.pl.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: clean
    type:
      - 'null'
      - boolean
    doc: removes temporary files
    inputBinding:
      position: 101
      prefix: --clean
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: filter_temperature
    type:
      - 'null'
      - int
    doc: desired melting temperature (default=65).
    inputBinding:
      position: 101
      prefix: --filter_temperature
  - id: input_file
    type: File
    doc: input_file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: output_file_path
    type: string
    doc: output_file
    inputBinding:
      position: 102
      prefix: --output_file
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Melting temperature report (output name, output name plus .json and _filtered_<temperature>.json)
    outputBinding:
      glob: $(inputs.output_file_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
