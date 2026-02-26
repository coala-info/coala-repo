cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncvalidator
label: esme_pnetcdf_openmpi_4_1_6_ncvalidator
doc: "Validate a netCDF file.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: input_file
    type: File
    doc: Input netCDF file name
    inputBinding:
      position: 1
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: Quiet mode (exit 1 when fail, 0 success)
    inputBinding:
      position: 102
      prefix: -q
  - id: repair_header
    type:
      - 'null'
      - boolean
    doc: Repair in-place the null-byte padding in file header.
    inputBinding:
      position: 102
      prefix: -x
  - id: trace_mode
    type:
      - 'null'
      - boolean
    doc: Turn on tracing mode, printing progress of validation
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/esme_pnetcdf_openmpi_4_1_6:1.14.0--hcc24ad4_0
stdout: esme_pnetcdf_openmpi_4_1_6_ncvalidator.out
