cwlVersion: v1.2
class: CommandLineTool
baseCommand: protrac
label: protrac
doc: "The provided text is a container runtime error log and does not contain help
  documentation or argument definitions for the tool 'protrac'.\n\nTool homepage:
  http://www.smallrnagroup.uni-mainz.de/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protrac:2.4.2--pl526_0
stdout: protrac.out
