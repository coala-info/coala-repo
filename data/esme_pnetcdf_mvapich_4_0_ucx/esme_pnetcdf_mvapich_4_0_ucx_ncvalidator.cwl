cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncvalidator
label: esme_pnetcdf_mvapich_4_0_ucx_ncvalidator
doc: "Validate netCDF files\n\nTool homepage: https://parallel-netcdf.github.io/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.file)
        writable: true
inputs:
  - id: file
    type: File
    doc: Input netCDF file name
    inputBinding:
      position: 1
  - id: trace
    type:
      - 'null'
      - boolean
    doc: Turn on tracing mode, printing progress of validation
    inputBinding:
      position: 0
      prefix: -t
  - id: repair_header
    type:
      - 'null'
      - boolean
    doc: Repair in-place the null-byte padding in file header.
    inputBinding:
      position: 0
      prefix: -x
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode (exit 1 when fail, 0 success)
    inputBinding:
      position: 0
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: repaired_file
    type:
      - 'null'
      - File
    doc: The input file after in-place repair (only with repair_header)
    outputBinding:
      glob: '$(inputs.repair_header ? inputs.file.basename : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
stdout: esme_pnetcdf_mvapich_4_0_ucx_ncvalidator.out
successCodes:
  - 0
  - 1
