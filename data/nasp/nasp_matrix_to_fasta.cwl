cwlVersion: v1.2
class: CommandLineTool
baseCommand: [matrix_to_fasta.py]
label: nasp_matrix_to_fasta
doc: "Convert a NASP matrix into FASTA files of the called positions.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: input_matrix
    type: File
    doc: "Path to NASP matrix."
    inputBinding:
      position: 1
      prefix: --input_matrix
  - id: output_prefix
    type: string
    doc: "Prefix for output files."
    inputBinding:
      position: 1
      prefix: --output_prefix
  - id: filter_frequency
    type:
      - 'null'
      - float
    doc: "Filter out missing data if missing is greater than or equal to the given frequency (default 1)."
    inputBinding:
      position: 1
      prefix: --filter_frequency
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: "Files written with the output prefix."
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
