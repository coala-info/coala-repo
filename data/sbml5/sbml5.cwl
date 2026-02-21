cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbml5
label: sbml5
doc: The provided text does not contain help information for the tool, but appears
  to be a container engine error log. No arguments could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sbml5:v5.17.2dfsg-3-deb-py3_cv1
stdout: sbml5.out
