cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sierrapy
  - recipe
label: sierrapy_recipe_alignment
doc: "Export aligned pol sequences from Sierra result.\n\nTool homepage: https://github.com/hivdb/sierra-client/tree/master/python"
inputs:
  - id: input_filename
    type: File
    doc: JSON result from Sierra web service.
    inputBinding:
      position: 1
      prefix: --input
  - id: output_filename
    type: string
    doc: File path to store the result.
    inputBinding:
      position: 2
      prefix: --output
  - id: gap_handling
    type:
      - 'null'
      - type: enum
        name: gap_handling_enum
        symbols: [squeeze, hxb2strip, hxb2stripkeepins]
    doc: Specify how you want the recipe to handle the gaps. squeeze keeps every
      gap in the result alignment; hxb2strip strips out non-HXB2 columns;
      hxb2stripkeepins strips non-HXB2 columns except codon insertions.
    inputBinding:
      position: 4
      prefix: --gap-handling
arguments:
  - position: 3
    valueFrom: alignment
outputs:
  - id: result
    type: File
    doc: File path to store the result.
    outputBinding:
      glob: $(inputs.output_filename)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
