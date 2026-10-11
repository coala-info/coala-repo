cwlVersion: v1.2
class: CommandLineTool
baseCommand: netcdf-metadata-info
label: netcdf-metadata-info
doc: "Provides information on Netcdf metadata, including details about variables and
  dimensions, and summarizes it into an output tabular file.\n\nTool homepage: https://github.com/Alanamosse/Netcdf-Metadata-Info/"
inputs:
  - id: input_netcdf_file
    type: File
    doc: The netcdf input file.
    inputBinding:
      position: 1
outputs:
  - id: output_tabular_file
    type: File
    doc: Tabular file variables.tabular with one line per variable (name, number of dimensions, then each dimension name and size). The tool always writes this fixed name.
    outputBinding:
      glob: variables.tabular
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netcdf-metadata-info:1.1.6--h7b50bb2_7
