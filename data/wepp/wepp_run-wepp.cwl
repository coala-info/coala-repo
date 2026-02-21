cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-wepp
label: wepp_run-wepp
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments could be extracted.\n\nTool homepage:
  https://github.com/TurakhiaLab/WEPP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wepp:0.1.5.1--hd668422_0
stdout: wepp_run-wepp.out
