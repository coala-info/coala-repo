cwlVersion: v1.2
class: CommandLineTool
baseCommand: justbackoff
label: justbackoff
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/admiralobvious/justbackoff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/justbackoff:0.4.0--py36_0
stdout: justbackoff.out
