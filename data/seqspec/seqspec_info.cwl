cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec_info
label: seqspec_info
doc: "Get information about spec.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: The output format, [tab, json]
    inputBinding:
      position: 102
      prefix: --format
  - id: key
    type:
      - 'null'
      - string
    doc: Object to display, [modalities, meta, sequence_spec, library_spec]
    inputBinding:
      position: 102
      prefix: --key
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
