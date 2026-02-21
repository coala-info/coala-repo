cwlVersion: v1.2
class: CommandLineTool
baseCommand: pp
label: pp
doc: "The provided text is a container build log and does not contain help information
  or usage instructions for the 'pp' tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/hrydgard/ppsspp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pp:1.6.5--py27_0
stdout: pp.out
