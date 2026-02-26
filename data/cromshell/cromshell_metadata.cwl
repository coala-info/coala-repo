cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - metadata
label: cromshell_metadata
doc: "Get the full metadata of a workflow.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_id
    type: string
    doc: Workflow ID
    inputBinding:
      position: 1
  - id: dont_expand_subworkflows
    type:
      - 'null'
      - boolean
    doc: Do not expand subworkflow info in metadata
    inputBinding:
      position: 102
      prefix: --dont-expand-subworkflows
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_metadata.out
