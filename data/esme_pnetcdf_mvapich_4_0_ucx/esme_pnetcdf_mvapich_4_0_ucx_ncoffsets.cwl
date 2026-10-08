cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncoffsets
label: esme_pnetcdf_mvapich_4_0_ucx_ncoffsets
doc: "Prints offsets of variables in a netCDF file.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: input_file
    type: File
    doc: Input netCDF file name
    inputBinding:
      position: 1
  - id: variables
    type:
      - 'null'
      - type: array
        items: string
    doc: Output for variable(s) <var1>,... only
    inputBinding:
      position: 0
      prefix: -v
      itemSeparator: ','
  - id: output_variable_size
    type:
      - 'null'
      - boolean
    doc: Output variable size. For record variables, output the size of one record
      only
    inputBinding:
      position: 0
      prefix: -s
  - id: output_gap
    type:
      - 'null'
      - boolean
    doc: Output gap from the previous variable
    inputBinding:
      position: 0
      prefix: -g
  - id: output_all_records
    type:
      - 'null'
      - boolean
    doc: Output offsets for all records
    inputBinding:
      position: 0
      prefix: -r
  - id: check_gaps_fixed_size
    type:
      - 'null'
      - boolean
    doc: Check gaps in fixed-size variables, output 1 if gaps are found, 0 for otherwise.
    inputBinding:
      position: 0
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
stdout: esme_pnetcdf_mvapich_4_0_ucx_ncoffsets.out
