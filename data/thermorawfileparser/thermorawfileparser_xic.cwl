cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ThermoRawFileParser
  - xic
label: thermorawfileparser_xic
doc: "Extract chromatograms (XIC) from a Thermo RAW file for the m/z ranges listed in a JSON file.\n\nTool homepage: https://github.com/CompOmics/ThermoRawFileParser"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: "The raw file input (Required). Specify this or an input directory -d"
    inputBinding:
      position: 101
      prefix: -i
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: "The directory containing the raw files (Required). Specify this or an input file -i."
    inputBinding:
      position: 101
      prefix: -d
  - id: json
    type: File
    doc: "The json input file (Required)."
    inputBinding:
      position: 101
      prefix: -j
  - id: print_example
    type:
      - 'null'
      - boolean
    doc: "Show a json input file example."
    inputBinding:
      position: 101
      prefix: -p
  - id: output
    type:
      - 'null'
      - string
    doc: "The output file. Specify this or an output directory. Specifying neither writes to the input directory."
    inputBinding:
      position: 101
      prefix: -b
  - id: output_directory
    type:
      - 'null'
      - string
    doc: "The output directory. Specify this or an output file. Specifying neither writes to the input directory."
    inputBinding:
      position: 101
      prefix: -o
  - id: base64
    type:
      - 'null'
      - boolean
    doc: "Encodes the content of the xic vectors as base 64 encoded string."
    inputBinding:
      position: 101
      prefix: '-6'
  - id: stdout_output
    type:
      - 'null'
      - boolean
    doc: "Pipes the output into standard output. Logging is being turned off."
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
    doc: "Standard output (chromatograms when -s is used)"
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Chromatograms in JSON format"
    outputBinding:
      glob: $(inputs.output)
  - id: output_directory_out
    type:
      - 'null'
      - Directory
    doc: "Output directory with the chromatogram files"
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.output_directory ? [{entryname: inputs.output_directory, entry: {class: 'Directory', listing: []}, writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thermorawfileparser:2.0.0.dev--h9ee0642_0
stdout: thermorawfileparser_xic.out
