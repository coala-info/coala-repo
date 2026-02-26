cwlVersion: v1.2
class: CommandLineTool
baseCommand: thermorawfileparser_xic
label: thermorawfileparser_xic
doc: "Parses Thermo Fisher Scientific raw files to extract XIC data.\n\nTool homepage:
  https://github.com/compomics/ThermoRawFileParser"
inputs:
  - id: base64
    type:
      - 'null'
      - boolean
    doc: Encodes the content of the xic vectors as base 64 encoded string.
    inputBinding:
      position: 101
      prefix: --base64
  - id: input_directory
    type: Directory
    doc: The directory containing the raw files (Required). Specify this or an 
      input file -i.
    inputBinding:
      position: 101
      prefix: --input_directory
  - id: input_file
    type: File
    doc: The raw file input (Required). Specify this or an input directory -d
    inputBinding:
      position: 101
      prefix: --input
  - id: json_input_file
    type: File
    doc: The json input file (Required). If you are not sure about the structure
      of the json file, use -p for printing an examplarily json input file
    inputBinding:
      position: 101
      prefix: --json
  - id: logging
    type:
      - 'null'
      - string
    doc: 'Optional logging level: 0 for silent, 1 for verbose, 2 for default, 3 for
      warning, 4 for error; both numeric and text (case insensitive) value recognized.'
    inputBinding:
      position: 101
      prefix: --logging
  - id: print_example
    type:
      - 'null'
      - boolean
    doc: Show a json input file example.
    inputBinding:
      position: 101
      prefix: --print_example
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Pipes the output into standard output. Logging is being turned off.
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
    doc: The output file. Specify this or an output directory. Specifying 
      neither writes to the input directory.
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The output directory. Specify this or an output file. Specifying 
      neither writes to the input directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thermorawfileparser:2.0.0.dev--h9ee0642_0
