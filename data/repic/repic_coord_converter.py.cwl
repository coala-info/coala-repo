cwlVersion: v1.2
class: CommandLineTool
baseCommand: repic_coord_converter.py
label: repic_coord_converter.py
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/ccameron/REPIC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
stdout: repic_coord_converter.py.out
