cwlVersion: v1.2
class: CommandLineTool
baseCommand: snaptools
label: snaptools
doc: "A module for processing snap files (Note: The provided text is a container execution
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://github.com/r3fang/SnapTools.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snaptools:1.4.8--py_0
stdout: snaptools.out
