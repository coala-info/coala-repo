cwlVersion: v1.2
class: CommandLineTool
baseCommand: cct
label: cct
doc: "Convert input data to Universal Transverse Mercator, zone 32 coordinates, based
  on the GRS80 ellipsoid.\n\nTool homepage: https://github.com/Eanya-Tonic/CCTV_Viewer"
inputs:
  - id: operator_specs
    type:
      - 'null'
      - type: array
        items: string
    doc: The operator specs describe the action to be performed by cct
    inputBinding:
      position: 1
  - id: infile
    type:
      type: array
      items: File
    doc: Input file(s)
    inputBinding:
      position: 2
  - id: decimals
    type:
      - 'null'
      - int
    doc: Specify number of decimals in output.
    inputBinding:
      position: 103
      prefix: -d
  - id: fixed_t_value
    type:
      - 'null'
      - string
    doc: Provide a fixed t value for all input data (e.g. -t 0)
    inputBinding:
      position: 103
      prefix: --time
  - id: fixed_z_value
    type:
      - 'null'
      - string
    doc: Provide a fixed z value for all input data (e.g. -z 0)
    inputBinding:
      position: 103
      prefix: --height
  - id: input_columns
    type:
      - 'null'
      - string
    doc: Specify input columns for (up to) 4 input parameters. Defaults to 
      1,2,3,4
    inputBinding:
      position: 103
      prefix: -c
  - id: inverse_transformation
    type:
      - 'null'
      - boolean
    doc: Do the inverse transformation
    inputBinding:
      position: 103
      prefix: --inverse
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: Skip n first lines of a infile
    inputBinding:
      position: 103
      prefix: --skip-lines
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Provide non-essential informational output. Repeat -v for more 
      verbosity (e.g. -vv)
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
