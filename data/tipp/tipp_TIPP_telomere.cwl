cwlVersion: v1.2
class: CommandLineTool
baseCommand: tipp
label: tipp_TIPP_telomere
doc: "The provided text is an error log from a container build process and does not
  contain CLI help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/Wenfei-Xian/TIPP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tipp:1.3.0--py38pl5321h077b44d_0
stdout: tipp_TIPP_telomere.out
