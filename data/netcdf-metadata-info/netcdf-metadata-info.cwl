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
    type:
      - 'null'
      - File
    doc: Output tabular file containing variable and dimension information.
    outputBinding:
      glob: $(inputs.output_tabular_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netcdf-metadata-info:1.1.6--h7b50bb2_7
