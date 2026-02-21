cwlVersion: v1.2
class: CommandLineTool
baseCommand: syri
label: syri
doc: "The provided text does not contain help information or usage instructions for
  the tool 'syri'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/schneebergerlab/syri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syri:1.7.1--py310ha6711e0_0
stdout: syri.out
