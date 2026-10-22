cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snk
  - list
label: snk_list
doc: "List the installed workflows.\n\nTool homepage: https://snk.wytamma.com"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show the workflow paths.
    inputBinding:
      position: 101
      prefix: --verbose
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
stdout: snk_list.out
