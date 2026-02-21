cwlVersion: v1.2
class: CommandLineTool
baseCommand: eviann
label: eviann
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/alekseyzimin/EviAnn_release"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eviann:2.0.5--pl5321haf24da9_0
stdout: eviann.out
