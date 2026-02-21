cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchlib
label: pp-sketchlib_sketchlib
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process. No arguments or tool descriptions could be
  extracted from the input.\n\nTool homepage: https://github.com/johnlees/pp-sketchlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pp-sketchlib:1.1.0--py37hcaab5c4_2
stdout: pp-sketchlib_sketchlib.out
