cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - workspace
label: philosopher_workspace
doc: "Manage the experiment workspace for the analysis\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: analytics
    type:
      - 'null'
      - boolean
    doc: "reports when a workspace is created for usage estimation"
    inputBinding:
      position: 100
      prefix: --analytics
  - id: backup
    type:
      - 'null'
      - boolean
    doc: "create a backup of the experiment meta data"
    inputBinding:
      position: 100
      prefix: --backup
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "remove the workspace and all meta data. Experimental file are kept intact"
    inputBinding:
      position: 100
      prefix: --clean
  - id: init
    type:
      - 'null'
      - boolean
    doc: "initialize the workspace"
    inputBinding:
      position: 100
      prefix: --init
  - id: nocheck
    type:
      - 'null'
      - boolean
    doc: "do not check for new versions"
    inputBinding:
      position: 100
      prefix: --nocheck
  - id: temp
    type:
      - 'null'
      - string
    doc: "define a custom temporary folder for Philosopher"
    inputBinding:
      position: 100
      prefix: --temp
  - id: workspace
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (the .meta folder written by an earlier step); it is staged writable as .meta in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: workspace_out
    type:
      - 'null'
      - Directory
    doc: "Philosopher workspace (.meta folder) created or changed by this step; pass it to the next step"
    outputBinding:
      glob: .meta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .meta
        entry: $(inputs.workspace)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_workspace.out
