cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdfdiff
label: esme_pnetcdf_mvapich_4_0_ofi_cdfdiff
doc: "Compare two netCDF files to identify differences in their contents, attributes,
  or dimensions.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: file1
    type: File
    doc: The first netCDF file to compare
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: The second netCDF file to compare
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Quiet mode: only return exit status'
    inputBinding:
      position: 103
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose mode: print differences'
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ofi_cdfdiff.out
