cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncvalidator
label: esme_pnetcdf_mvapich_4_0_ucx_ncvalidator
doc: "Validate netCDF files\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: input_file
    type: File
    doc: Input netCDF file name
    inputBinding:
      position: 1
  - id: quiet
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
  - id: trace
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
      quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
stdout: esme_pnetcdf_mvapich_4_0_ucx_ncvalidator.out
