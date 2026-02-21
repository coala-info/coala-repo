cwlVersion: v1.2
class: CommandLineTool
baseCommand: netcdf-metadata-info
label: netcdf-metadata-info
doc: "A tool to extract and display metadata information from NetCDF files.\n\nTool
  homepage: https://github.com/Alanamosse/Netcdf-Metadata-Info/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netcdf-metadata-info:1.1.6--h7b50bb2_7
stdout: netcdf-metadata-info.out
