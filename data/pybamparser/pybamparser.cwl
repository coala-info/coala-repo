cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybamparser
label: pybamparser
doc: "A tool for parsing BAM files (Note: The provided text is an error log and does
  not contain help documentation or argument details).\n\nTool homepage: https://github.com/blankenberg/pyBamParser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybamparser:0.0.3--py27_1
stdout: pybamparser.out
