cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmetashot_kMetaShot_classifier_NV.py
label: kmetashot_kMetaShot_classifier_NV.py
doc: "kMetaShot classifier (Note: The provided text contains system log and error
  messages rather than tool help documentation; no arguments could be extracted.)\n
  \nTool homepage: https://github.com/gdefazio/kMetaShot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmetashot:2.0--pyh7e72e81_1
stdout: kmetashot_kMetaShot_classifier_NV.py.out
