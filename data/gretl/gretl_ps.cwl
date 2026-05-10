cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl_ps
label: gretl_ps
doc: "How much core, soft and private genome is in each sample?\n\nTool homepage:
  https://github.com/moinsebi/gretl"
inputs:
  - id: gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: pansn
    type:
      - 'null'
      - string
    doc: Separate by first entry in Pan-SN spec
    inputBinding:
      position: 101
      prefix: --pansn
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
