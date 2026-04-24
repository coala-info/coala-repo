cwlVersion: v1.2
class: CommandLineTool
baseCommand: drprg index
label: drprg_index
doc: "Download and interact with indices\n\nTool homepage: https://github.com/mbhall88/drprg"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: The name/path of the index to download
    inputBinding:
      position: 1
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download a prebuilt index
    inputBinding:
      position: 102
      prefix: --download
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing indices
    inputBinding:
      position: 102
      prefix: --force
  - id: list
    type:
      - 'null'
      - boolean
    doc: List all available (and downloaded) indices
    inputBinding:
      position: 102
      prefix: --list
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: "Index directory\n          \n          Use this if your indices are not
      in a default location, or you want to download them to a non-default location"
    inputBinding:
      position: 102
      prefix: --outdir
  - id: threads
    type:
      - 'null'
      - int
    doc: "Maximum number of threads to use\n          \n          Use 0 to select
      the number automatically"
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drprg:0.1.1--h5076881_1
stdout: drprg_index.out
