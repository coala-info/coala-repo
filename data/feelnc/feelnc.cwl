cwlVersion: v1.2
class: CommandLineTool
baseCommand: feelnc
label: feelnc
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container environment (Apptainer/Singularity)
  failing to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/tderrien/FEELnc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc.out
