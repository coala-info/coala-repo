cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymot
label: pymot
doc: "Python Motif Discovery tool (Note: The provided text is a container build error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/dhellmann/pymotw-3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymot:13.09.2016--py27_1
stdout: pymot.out
