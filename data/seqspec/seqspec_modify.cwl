cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec_modify
label: seqspec_modify
doc: "Modify attributes of various elements in a seqspec file using JSON objects.\n\
  \nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
  - id: keys
    type: string
    doc: JSON array of objects to modify. Each object must include an id field 
      (read_id, region_id, file_id, kit_id, protocol_id, or assay_id).
    inputBinding:
      position: 102
      prefix: --keys
  - id: modality
    type: string
    doc: Modality of the assay
    inputBinding:
      position: 102
      prefix: --modality
  - id: selector
    type:
      - 'null'
      - string
    doc: Selector for ID, [read, region, file, seqkit, seqprotocol, libkit, 
      libprotocol, assay]
    default: read
    inputBinding:
      position: 102
      prefix: --selector
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
