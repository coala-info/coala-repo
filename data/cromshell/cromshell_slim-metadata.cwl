cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - slim-metadata
label: cromshell_slim-metadata
doc: "Get a subset of the workflow metadata.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
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
  - id: exclude_keys
    type:
      - 'null'
      - boolean
    doc: Toggle to either include or exclude keys that are specified by the 
      --keys option or in the cromshell config JSON.
    inputBinding:
      position: 102
      prefix: --exclude_keys
  - id: keys
    type:
      - 'null'
      - string
    doc: Use keys to get a subset of the metadata for a workflow. Separate 
      multiple keys by comma (e.g. '-k id[,status,...]').
    inputBinding:
      position: 102
      prefix: --keys
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_slim-metadata.out
