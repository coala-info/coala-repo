cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqt
label: sqt
doc: "Sequence Quality Tools (Note: The provided text is a container build log and
  does not contain help information or argument definitions.)\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt.out
