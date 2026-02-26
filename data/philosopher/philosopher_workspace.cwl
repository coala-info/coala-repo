cwlVersion: v1.2
class: CommandLineTool
baseCommand: philosopher workspace
label: philosopher_workspace
doc: "Manage the experiment workspace for the analysis\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: analytics
    type:
      - 'null'
      - boolean
    doc: reports when a workspace is created for usage estimation
    default: true
    inputBinding:
      position: 101
      prefix: --analytics
  - id: backup
    type:
      - 'null'
      - boolean
    doc: create a backup of the experiment meta data
    inputBinding:
      position: 101
      prefix: --backup
  - id: clean
    type:
      - 'null'
      - boolean
    doc: remove the workspace and all meta data. Experimental file are kept 
      intact
    inputBinding:
      position: 101
      prefix: --clean
  - id: init
    type:
      - 'null'
      - boolean
    doc: initialize the workspace
    inputBinding:
      position: 101
      prefix: --init
  - id: nocheck
    type:
      - 'null'
      - boolean
    doc: do not check for new versions
    inputBinding:
      position: 101
      prefix: --nocheck
  - id: temp
    type:
      - 'null'
      - string
    doc: define a custom temporary folder for Philosopher
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_workspace.out
