cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-cobra
label: python3-cobra
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/machinezone/cobra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-cobra:v0.5.9-1-deb_cv1
stdout: python3-cobra.out
