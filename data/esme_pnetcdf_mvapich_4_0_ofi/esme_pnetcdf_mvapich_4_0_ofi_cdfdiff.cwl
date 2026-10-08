cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdfdiff
label: esme_pnetcdf_mvapich_4_0_ofi_cdfdiff
doc: "Compare the contents of two files in classic netCDF formats.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: file1
    type: File
    doc: First input netCDF file to be compared
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second input netCDF file to be compared
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 0
      prefix: -b
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet mode (no output if two files are the same)
    inputBinding:
      position: 0
      prefix: -q
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Compare header information only, no variables
    inputBinding:
      position: 0
      prefix: -h
  - id: variables
    type:
      - 'null'
      - type: array
        items: string
    doc: Compare variable(s) <var1>,... only
    inputBinding:
      position: 0
      prefix: -v
      itemSeparator: ','
  - id: tolerance
    type:
      - 'null'
      - string
    doc: 'Tolerance "diff,ratio": diff is absolute element-wise difference and ratio
      is relative element-wise difference defined as |x - y|/max(|x|, |y|)'
    inputBinding:
      position: 0
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ofi:1.14.1--hb2a3317_0
stdout: esme_pnetcdf_mvapich_4_0_ofi_cdfdiff.out
successCodes:
  - 0
  - 1
