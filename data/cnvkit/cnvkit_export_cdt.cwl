cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - export
  - cdt
label: cnvkit_export_cdt
doc: "Convert log2 ratios to CDT format. Compatible with Java TreeView.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: "Log2 copy ratio data file(s) (*.cnr), the output of the 'fix' sub-command."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
