cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-cobra_bavarde
label: python3-cobra_bavarde
doc: "A tool related to the python3-cobra package. Note: The provided text is a system
  error log regarding a container build failure and does not contain usage instructions
  or argument definitions.\n\nTool homepage: https://github.com/machinezone/cobra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-cobra:v0.5.9-1-deb_cv1
stdout: python3-cobra_bavarde.out
