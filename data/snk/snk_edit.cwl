cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snk
  - edit
label: snk_edit
doc: "Access the snk.yaml configuration file for a workflow.\n\nTool homepage: https://snk.wytamma.com"
inputs:
  - id: workflow_name
    type: string
    doc: Name of the workflow to configure.
    inputBinding:
      position: 1
  - id: show_path
    type:
      - 'null'
      - boolean
    doc: Show the path to the snk.yaml file.
    inputBinding:
      position: 102
      prefix: --path
  - id: snk_store
    type:
      - 'null'
      - Directory
    doc: Existing snk workflow store (the .local/snk folder written by snk install),
      staged into the home directory so that installed workflows can be found.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .local/snk
        entry: $(inputs.snk_store)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
stdout: snk_edit.out
