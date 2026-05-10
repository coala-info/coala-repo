cwlVersion: v1.2
class: CommandLineTool
baseCommand: predictosaurus plot
label: predictosaurus_plot
doc: "Create visualizations and output HTML, TSV, or Vega specs\n\nTool homepage:
  https://github.com/fxwiegand/predictosaurus"
inputs:
  - id: input
    type: File
    doc: Path to the input data file
    inputBinding:
      position: 101
      prefix: --input
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Path to the output TSV file containing the predicted scores per 
      transcript
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predictosaurus:0.8.4--hbcba35e_0
