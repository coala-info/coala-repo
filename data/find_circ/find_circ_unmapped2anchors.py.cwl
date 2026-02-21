cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_circ_unmapped2anchors.py
label: find_circ_unmapped2anchors.py
doc: "A tool for processing unmapped reads into anchors for circular RNA detection.
  Note: The provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://github.com/marvin-jens/find_circ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/find_differential_primers:0.1.4--py_0
stdout: find_circ_unmapped2anchors.py.out
