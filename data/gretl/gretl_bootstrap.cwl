cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl_bootstrap
label: gretl_bootstrap
doc: "Bootstrap approach\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs:
  - id: gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: nodes
    type:
      - 'null'
      - string
    doc: Run bootstrap only on these nodes
    inputBinding:
      position: 101
      prefix: --nodes
  - id: number
    type:
      - 'null'
      - int
    doc: How many bootstraps do you want to run
    inputBinding:
      position: 101
      prefix: --number
  - id: output
    type: string
    doc: Output
    inputBinding:
      position: 101
      prefix: --output
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
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: meta_output_path
    type: string
    doc: Output or path parameter `meta_output_path`
    inputBinding:
      position: 102
      prefix: --meta-output
outputs:
  - id: meta_output
    type:
      - 'null'
      - File
    doc: Output meta file
    outputBinding:
      glob: $(inputs.meta_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
