cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mageck
  - vis
label: mageck_mageck-vis
doc: "The provided text does not contain help information or usage instructions; it
  contains system error messages related to a container build failure (no space left
  on device).\n\nTool homepage: http://mageck.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
stdout: mageck_mageck-vis.out
