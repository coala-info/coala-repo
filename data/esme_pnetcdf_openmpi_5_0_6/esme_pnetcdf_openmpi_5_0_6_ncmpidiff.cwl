cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncmpidiff
label: esme_pnetcdf_openmpi_5_0_6_ncmpidiff
doc: "Compare the contents of two netCDF files.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: file1
    type: File
    doc: File name of the first input netCDF file to be compared
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: File name of the second input netCDF file to be compared
    inputBinding:
      position: 2
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Compare header information only, no variables
    inputBinding:
      position: 103
      prefix: -h
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet mode (no output if two files are the same)
    inputBinding:
      position: 103
      prefix: -q
  - id: tolerance
    type:
      - 'null'
      - string
    doc: 'Tolerance: diff is absolute element-wise difference and ratio is relative
      element-wise difference defined as |x - y|/max(|x|, |y|)'
    inputBinding:
      position: 103
      prefix: -t
  - id: variables
    type:
      - 'null'
      - type: array
        items: string
    doc: Compare variable(s) <var1>,... only
    inputBinding:
      position: 103
      prefix: -v
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0
stdout: esme_pnetcdf_openmpi_5_0_6_ncmpidiff.out
