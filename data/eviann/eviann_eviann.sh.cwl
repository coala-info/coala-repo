cwlVersion: v1.2
class: CommandLineTool
baseCommand: eviann_eviann.sh
label: eviann_eviann.sh
doc: "Evidence-based Annotation (EviAnn) tool. Note: The provided help text contains
  only system error logs regarding container image building and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/alekseyzimin/EviAnn_release"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eviann:2.0.5--pl5321haf24da9_0
stdout: eviann_eviann.sh.out
