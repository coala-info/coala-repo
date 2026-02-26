cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - chars
label: sqt_chars
doc: "Print the number of characters in a string.\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: string
    type: string
    doc: The string
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_chars.out
