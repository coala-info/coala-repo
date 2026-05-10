cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl_id2int
label: gretl_id2int
doc: "Convert node identifier to numeric values (not sorted)\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs:
  - id: gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: dict_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `dict_path`
    inputBinding:
      position: 102
      prefix: --dict
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: dict
    type:
      - 'null'
      - File
    doc: Write a dictionary for Old->New identifiers in this file.
    outputBinding:
      glob: $(inputs.dict_path)
  - id: output
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
