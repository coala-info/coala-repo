cwlVersion: v1.2
class: CommandLineTool
baseCommand: grep
label: grep
doc: "Search for PATTERN in each FILE\n\nTool homepage: https://www.gnu.org/software/grep/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ubuntu:latest
stdout: grep.out
