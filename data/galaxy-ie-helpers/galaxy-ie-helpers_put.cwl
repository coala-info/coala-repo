cwlVersion: v1.2
class: CommandLineTool
baseCommand: put
label: galaxy-ie-helpers_put
doc: "Put datasets back into Galaxy.\n\nTool homepage: https://github.com/bgruening/galaxy_ie_helpers"
inputs:
  - id: filepaths
    type:
      type: array
      items: File
    doc: Specify the path to the files that should be uploaded to Galaxy.
    inputBinding:
      position: 1
  - id: filetype
    type:
      - 'null'
      - string
    doc: Galaxy file format. If not specified Galaxy will try to guess the 
      filetype automatically.
    inputBinding:
      position: 102
      prefix: --filetype
  - id: history_id
    type:
      - 'null'
      - string
    doc: History ID. The history ID and the dataset ID uniquly identify a 
      dataset. Per default this is set to the current Galaxy history.
    inputBinding:
      position: 102
      prefix: --history-id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-ie-helpers:0.2.7--pyh7cba7a3_0
stdout: galaxy-ie-helpers_put.out
