cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqspec
  - onlist
label: seqspec_onlist
doc: "Get onlist file for specific region. Onlist is a list of permissible sequences
  for a region.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
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
    doc: Format for combining multiple onlists (product, multi)
    inputBinding:
      position: 102
      prefix: --format
  - id: id
    type: string
    doc: ID to search for
    inputBinding:
      position: 102
      prefix: --id
  - id: modality
    type: string
    doc: Modality
    inputBinding:
      position: 102
      prefix: --modality
  - id: selector
    type:
      - 'null'
      - string
    doc: Selector for ID, [read, region, region-type]
    inputBinding:
      position: 102
      prefix: --selector
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
    doc: Path to output file (required for download/join operations)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
