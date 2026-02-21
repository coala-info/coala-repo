cwlVersion: v1.2
class: CommandLineTool
baseCommand: w4mclstrpeakpics
label: w4mclstrpeakpics
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/fetch process.\n\nTool homepage: https://github.com/HegemanLab/w4mclstrpeakpics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/w4mclstrpeakpics:0.98.1--r351_1
stdout: w4mclstrpeakpics.out
