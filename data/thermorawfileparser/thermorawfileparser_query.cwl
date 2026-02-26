cwlVersion: v1.2
class: CommandLineTool
baseCommand: thermorawfileparser_query
label: thermorawfileparser_query
doc: "Parses Thermo raw files and queries scan information.\n\nTool homepage: https://github.com/compomics/ThermoRawFileParser"
inputs:
  - id: input_file
    type: File
    doc: The raw file input (Required).
    inputBinding:
      position: 101
      prefix: --input
  - id: logging
    type:
      - 'null'
      - string
    doc: 'Optional logging level: 0 for silent, 1 for verbose, 2 for default, 3 for
      warning, 4 for error; both numeric and text (case insensitive) value recognized.'
    default: '2'
    inputBinding:
      position: 101
      prefix: --logging
  - id: no_peak_picking
    type:
      - 'null'
      - boolean
    doc: Don't use the peak picking provided by the native Thermo library. By 
      default peak picking is enabled.
    inputBinding:
      position: 101
      prefix: --noPeakPicking
  - id: scans
    type:
      - 'null'
      - string
    doc: The scan numbers. e.g. "1-5, 20, 25-30"
    inputBinding:
      position: 101
      prefix: --scans
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Pipes the output into standard output. Logging is being turned off
    inputBinding:
      position: 101
      prefix: --stdout
  - id: warnings_are_errors
    type:
      - 'null'
      - boolean
    doc: Return non-zero exit code for warnings; default only for errors
    inputBinding:
      position: 101
      prefix: --warningsAreErrors
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file. Specifying none writes the output file to the input 
      file parent directory.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thermorawfileparser:2.0.0.dev--h9ee0642_0
