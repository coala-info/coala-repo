cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.analysis.hamilton_path
label: knot-asm-analysis_knot.analysis.hamilton_path
doc: "Search Hamilton paths in an assembly-assembly graph (AAG)\n\nTool homepage: https://github.com/natir/knot"
inputs:
  - id: input
    type: File
    doc: path to the AAG
    inputBinding:
      position: 101
      prefix: --input
  - id: circular
    type:
      - 'null'
      - boolean
    doc: genome is circular
    inputBinding:
      position: 101
      prefix: --circular
  - id: output_path
    type: string
    doc: path where hamilton path was write
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: hamilton path report
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
