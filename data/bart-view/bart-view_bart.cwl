cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart
label: bart-view_bart
doc: "BART. Available commands are:\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: command
    type: string
    doc: The BART command to execute.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart-view:v0.1.00-2-deb_cv1
stdout: bart-view_bart.out
