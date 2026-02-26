cwlVersion: v1.2
class: CommandLineTool
baseCommand: get
label: galaxy-ie-helpers_get
doc: "Get datasets from Galaxy.\n\nTool homepage: https://github.com/bgruening/galaxy_ie_helpers"
inputs:
  - id: ids
    type:
      type: array
      items: string
    doc: The dataset ID/name from your Galaxy history, or a regex pattern to 
      search all files in the history
    inputBinding:
      position: 1
  - id: history_id
    type:
      - 'null'
      - string
    doc: History ID. The history ID and the dataset ID uniquly identify a 
      dataset. Per default this is set to the current Galaxy history.
    inputBinding:
      position: 102
      prefix: --history-id
  - id: identifier_type
    type:
      - 'null'
      - string
    doc: Type of the argument File/ID Number. Per default, integer ID number. If
      a pattern is specified in the -i argument, then this argument should be 
      set to "regex"
    inputBinding:
      position: 102
      prefix: --identifier_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-ie-helpers:0.2.7--pyh7cba7a3_0
stdout: galaxy-ie-helpers_get.out
