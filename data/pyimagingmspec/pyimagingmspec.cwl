cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyimagingmspec
label: pyimagingmspec
doc: "The provided text contains system logs and error messages related to a container
  build process rather than the command-line help documentation for pyimagingmspec.
  As a result, no arguments or tool descriptions could be extracted.\n\nTool homepage:
  https://github.com/alexandrovteam/pyImagingMSpec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyimagingmspec:0.1.4--py35_0
stdout: pyimagingmspec.out
