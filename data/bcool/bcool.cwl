cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcool
label: bcool
doc: "A tool for short read correction using de Bruijn graphs. (Note: The provided
  text contains only system error logs and no help documentation; arguments could
  not be extracted from the input.)\n\nTool homepage: https://github.com/Malfoy/BCOOL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcool:1.0.0--hdfd78af_2
stdout: bcool.out
