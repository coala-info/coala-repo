cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.analysis.generate_report
label: knot-asm-analysis_knot.analysis
doc: "Generate a report from knot output.\n\nTool homepage: https://github.com/natir/knot"
inputs:
  - id: classification
    type:
      - 'null'
      - boolean
    doc: Add path classification in report
    inputBinding:
      position: 101
      prefix: --classification
  - id: hamilton_path
    type:
      - 'null'
      - boolean
    doc: Add hamilton path in report
    inputBinding:
      position: 101
      prefix: --hamilton-path
  - id: input_prefix
    type: string
    doc: prefix of knot output
    inputBinding:
      position: 101
      prefix: --input_prefix
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: path where report was write
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
