cwlVersion: v1.2
class: CommandLineTool
baseCommand: mispipe
label: moreutils_mispipe
doc: "Pipe two commands together and return the exit status of the first command.\n
  \nTool homepage: https://github.com/madx/moreutils"
inputs:
  - id: command1
    type: string
    doc: The first command to execute in the pipeline.
    inputBinding:
      position: 1
  - id: command2
    type: string
    doc: The second command to execute in the pipeline.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_mispipe.out
