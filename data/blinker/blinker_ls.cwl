cwlVersion: v1.2
class: CommandLineTool
baseCommand: blinker_ls
label: blinker_ls
doc: "List directory contents\n\nTool homepage: https://github.com/blinksh/blink"
inputs:
  - id: path
    type:
      - 'null'
      - string
    doc: Directory to list (defaults to current directory)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blinker:1.4--py35_0
stdout: blinker_ls.out
