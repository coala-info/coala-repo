cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_descriptions.py
label: picrust2_add_descriptions.py
doc: "Add descriptions to PICRUSt2 output files.\n\nTool homepage: https://github.com/picrust/picrust2"
inputs:
  - id: custom_map_table
    type:
      - 'null'
      - File
    doc: Path to a custom mapping table
    inputBinding:
      position: 101
      prefix: --custom_map_table
  - id: input
    type: File
    doc: Input file path
    inputBinding:
      position: 101
      prefix: --input
  - id: map_type
    type:
      - 'null'
      - string
    doc: Type of mapping to use (METACYC, EC, KO, PFAM, GO)
    inputBinding:
      position: 101
      prefix: --map_type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
