cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ThermoRawFileParser
  - query
label: thermorawfileparser_query
doc: "Extract the spectra of selected scan numbers from a Thermo RAW file as JSON.\n\nTool homepage: https://github.com/CompOmics/ThermoRawFileParser"
inputs:
  - id: input
    type: File
    doc: "The raw file input (Required)."
    inputBinding:
      position: 101
      prefix: -i
  - id: scans
    type:
      - 'null'
      - string
    doc: "The scan numbers. e.g. \"1-5, 20, 25-30\""
    inputBinding:
      position: 101
      prefix: -n
  - id: output
    type:
      - 'null'
      - string
    doc: "The output file. Specifying none writes the output file to the input file parent directory."
    inputBinding:
      position: 101
      prefix: -b
  - id: no_peak_picking
    type:
      - 'null'
      - boolean
    doc: "Don't use the peak picking provided by the native Thermo library. By default peak picking is enabled."
    inputBinding:
      position: 101
      prefix: -p
  - id: stdout_output
    type:
      - 'null'
      - boolean
    doc: "Pipes the output into standard output. Logging is being turned off"
    inputBinding:
      position: 101
      prefix: -s
  - id: warnings_are_errors
    type:
      - 'null'
      - boolean
    doc: "Return non-zero exit code for warnings; default only for errors"
    inputBinding:
      position: 101
      prefix: -w
  - id: logging
    type:
      - 'null'
      - string
    doc: "The logging level: 0 for silent, 1 for verbose, 2 for default, 3 for warning, 4 for error; both numeric and text (case insensitive) value recognized."
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output (spectra when -s is used)"
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Spectra in JSON format"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thermorawfileparser:2.0.0.dev--h9ee0642_0
stdout: thermorawfileparser_query.out
