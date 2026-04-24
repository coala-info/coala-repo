cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec_find
label: seqspec_find
doc: "Find objects in the spec.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
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
    doc: Selector, [read,region,file,region-type]
    inputBinding:
      position: 102
      prefix: --selector
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
