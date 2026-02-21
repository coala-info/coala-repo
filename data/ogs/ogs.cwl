cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogs
label: ogs
doc: "OpenGeoSys (OGS) is a scientific open-source project for the development of
  numerical methods for the simulation of thermo-hydro-mechanical-chemical (THMC)
  processes in porous and fractured media. Note: The provided text contains container
  runtime error messages rather than the tool's help documentation, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/OGSR/OGSR-Engine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ogs:6.5.3
stdout: ogs.out
