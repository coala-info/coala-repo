cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qhery
  - list_rx
label: qhery_list_rx
doc: "List resistance genes from the Stanford resistance database.\n\nTool homepage:
  http://github.com/mjsull/qhery/"
inputs:
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Directory with latest Stanford resistance database.
    inputBinding:
      position: 101
      prefix: --database_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhery:0.1.2--pyhdfd78af_0
stdout: qhery_list_rx.out
