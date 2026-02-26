cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmetashot_kMetaShot_test.py
label: kmetashot_kMetaShot_test.py
doc: "kMetaShot installation test\n\nTool homepage: https://github.com/gdefazio/kMetaShot"
inputs:
  - id: reference
    type: File
    doc: Path to HDF5 file containing reference
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmetashot:2.0--pyh7e72e81_1
stdout: kmetashot_kMetaShot_test.py.out
