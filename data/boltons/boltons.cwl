cwlVersion: v1.2
class: CommandLineTool
baseCommand: boltons
label: boltons
doc: "Boltons is a set of over 230 utility strategy, data structures, and logic missing
  from the Python standard library. (Note: The provided text contains error logs regarding
  a failed container build and does not include CLI help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/mahmoud/boltons"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/boltons:16.4.1--py36_0
stdout: boltons.out
