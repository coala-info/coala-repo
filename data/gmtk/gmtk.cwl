cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmtk
label: gmtk
doc: "The provided text does not contain help information or usage instructions for
  the tool; it consists of container runtime log messages and a fatal error indicating
  a lack of disk space during a container build.\n\nTool homepage: https://github.com/Britishgaming/GMTK-Unity-Tutorial"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmtk:1.4.4--h4c2f4bb_16
stdout: gmtk.out
