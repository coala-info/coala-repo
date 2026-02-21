cwlVersion: v1.2
class: CommandLineTool
baseCommand: nc_info
label: netcdf-metadata-info_nc_info
doc: "A tool to extract metadata information from NetCDF files. Note: The provided
  help text contains a fatal system error regarding container execution and does not
  list specific command-line arguments.\n\nTool homepage: https://github.com/Alanamosse/Netcdf-Metadata-Info/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netcdf-metadata-info:1.1.6--h7b50bb2_7
stdout: netcdf-metadata-info_nc_info.out
