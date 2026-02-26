cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec_insert
label: seqspec_insert
doc: "Draft spec to modify\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: string
    doc: Draft spec to modify
    inputBinding:
      position: 1
  - id: after_id
    type:
      - 'null'
      - string
    doc: Insert after region ID (only for --selector region)
    inputBinding:
      position: 102
      prefix: --after
  - id: modality
    type: string
    doc: Target modality
    inputBinding:
      position: 102
      prefix: --modality
  - id: resource
    type: string
    doc: "Path or inline JSON. For reads, expects a list of objects like '[{\"read_id\"\
      : \"R1\", \"files\": [\"r1.fastq.gz\"]}]'."
    inputBinding:
      position: 102
      prefix: --resource
  - id: selector
    type: string
    doc: Section to insert into
    inputBinding:
      position: 102
      prefix: --selector
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write updated spec
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
