cwlVersion: v1.2
class: CommandLineTool
baseCommand: sed
label: sed
doc: "Stream editor for filtering and transforming text\n\nTool homepage: https://www.gnu.org/software/sed/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
stdout: sed.out
