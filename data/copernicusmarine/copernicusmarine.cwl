cwlVersion: v1.2
class: CommandLineTool
baseCommand: copernicusmarine
label: copernicusmarine
doc: "The Copernicus Marine Toolbox is a CLI tool to browse and download products
  from the Copernicus Marine Service.\n\nTool homepage: https://github.com/pepijn-devries/CopernicusMarine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/copernicusmarine:2.3.0
stdout: copernicusmarine.out
