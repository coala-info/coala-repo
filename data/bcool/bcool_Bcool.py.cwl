cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcool_Bcool.py
label: bcool_Bcool.py
doc: "Bcool is a tool for short read correction (based on the provided tool name hint
  and container metadata). Note: The provided text appears to be a system error log
  rather than help text, so no arguments could be extracted.\n\nTool homepage: https://github.com/Malfoy/BCOOL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcool:1.0.0--hdfd78af_2
stdout: bcool_Bcool.py.out
