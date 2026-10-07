cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - export
  - nexus-basic
label: cnvkit_export_nexus-basic
doc: "Convert bin-level log2 ratios to Nexus Copy Number \"basic\" format.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filename
    type: File
    doc: "Log2 copy ratio data file (*.cnr), the output of the 'fix' sub-command."
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
