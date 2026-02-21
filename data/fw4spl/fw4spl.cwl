cwlVersion: v1.2
class: CommandLineTool
baseCommand: fw4spl
label: fw4spl
doc: "Framework for Software Production Line (Medical imaging software framework)\n
  \nTool homepage: https://github.com/fw4spl-org/fw4spl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fw4spl:v17.2.0-2-deb_cv1
stdout: fw4spl.out
