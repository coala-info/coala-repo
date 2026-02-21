cwlVersion: v1.2
class: CommandLineTool
baseCommand: wade
label: wade
doc: "WGS Analysis of De novo mutations (Note: The provided text is a container build
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/phac-nml/wade"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wade:1.2.0--r44hdfd78af_0
stdout: wade.out
