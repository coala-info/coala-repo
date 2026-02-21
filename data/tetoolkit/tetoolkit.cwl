cwlVersion: v1.2
class: CommandLineTool
baseCommand: tetoolkit
label: tetoolkit
doc: "The provided text does not contain help information for tetoolkit; it is a log
  of a failed container build process.\n\nTool homepage: http://hammelllab.labsites.cshl.edu/software#TEToolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetoolkit:2.0.3--py27_0
stdout: tetoolkit.out
