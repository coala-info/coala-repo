cwlVersion: v1.2
class: CommandLineTool
baseCommand: strling
label: strling
doc: "Short Tandem Repeat Genotyping tool (Note: The provided text is a container
  build error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/quinlan-lab/STRling"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
stdout: strling.out
