cwlVersion: v1.2
class: CommandLineTool
baseCommand: mageck
label: mageck
doc: "The provided text does not contain help information for the mageck tool. It
  contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to build an image due to insufficient disk space.\n\nTool homepage: http://mageck.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
stdout: mageck.out
