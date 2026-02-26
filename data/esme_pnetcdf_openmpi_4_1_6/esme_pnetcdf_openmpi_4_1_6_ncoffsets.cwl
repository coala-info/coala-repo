cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncoffsets
label: esme_pnetcdf_openmpi_4_1_6_ncoffsets
doc: "Prints offsets of variables in a netCDF file.\n\nTool homepage: https://parallel-netcdf.github.io/"
inputs:
  - id: input_file
    type: File
    doc: Input netCDF file name
    inputBinding:
      position: 1
  - id: check_gaps_fixed_size
    type:
      - 'null'
      - boolean
    doc: Check gaps in fixed-size variables, output 1 if gaps are found, 0 for 
      otherwise.
    inputBinding:
      position: 102
      prefix: -x
  - id: output_all_record_offsets
    type:
      - 'null'
      - boolean
    doc: Output offsets for all records
    inputBinding:
      position: 102
      prefix: -r
  - id: output_gap
    type:
      - 'null'
      - boolean
    doc: Output gap from the previous variable
    inputBinding:
      position: 102
      prefix: -g
  - id: output_variable_size
    type:
      - 'null'
      - boolean
    doc: Output variable size. For record variables, output the size of one 
      record only
    inputBinding:
      position: 102
      prefix: -s
  - id: output_variables
    type:
      - 'null'
      - type: array
        items: string
    doc: Output for variable(s) only
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/esme_pnetcdf_openmpi_4_1_6:1.14.0--hcc24ad4_0
stdout: esme_pnetcdf_openmpi_4_1_6_ncoffsets.out
