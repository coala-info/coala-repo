cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrad
label: pyrad
doc: "The provided text does not contain help information or argument definitions
  for pyrad; it is a log of a failed container build process.\n\nTool homepage: https://github.com/dereneaton/pyrad"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrad:3.0.66--py27_0
stdout: pyrad.out
