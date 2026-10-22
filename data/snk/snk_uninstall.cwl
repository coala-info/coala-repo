cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snk
  - uninstall
label: snk_uninstall
doc: "Uninstall a workflow.\n\nTool homepage: https://snk.wytamma.com"
inputs:
  - id: name
    type: string
    doc: Name of the workflow to uninstall.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force uninstall without asking.
    inputBinding:
      position: 102
      prefix: --force
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
  - id: remaining_workflows
    type: Directory
    doc: The snk workflow store after the uninstall
    outputBinding:
      glob: .local/snk
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .local/snk
        entry: $(inputs.snk_store)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
stdout: snk_uninstall.out
