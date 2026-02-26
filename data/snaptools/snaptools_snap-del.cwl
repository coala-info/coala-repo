cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snaptools
  - snap-del
label: snaptools_snap-del
doc: "Delete a session from a snap file.\n\nTool homepage: https://github.com/r3fang/SnapTools.git"
inputs:
  - id: session_name
    type: string
    doc: "session to be deleted in snap file. 'AM': cell-by-bin matrix. All cell-by-bin
      matrices will be removed. 'PM': cell-by-peak matrix. 'GM': cell-by-gene matrix."
    inputBinding:
      position: 101
      prefix: --session-name
  - id: snap_file
    type: File
    doc: snap file.
    inputBinding:
      position: 101
      prefix: --snap-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snaptools:1.4.8--py_0
stdout: snaptools_snap-del.out
