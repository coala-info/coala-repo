cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringify
label: ucsc-stringify_stringify
doc: "Convert file to C strings. A stringified version of the input is printed to standard output.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input file to convert
    inputBinding:
      position: 3
  - id: variable_name
    type:
      - 'null'
      - string
    doc: Create a variable with the specified name containing the string.
    inputBinding:
      position: 0
      prefix: -var=
      separate: false
  - id: static_variable
    type:
      - 'null'
      - boolean
    doc: Create the variable but put static in front of it.
    inputBinding:
      position: 1
      prefix: -static
  - id: array_of_strings
    type:
      - 'null'
      - boolean
    doc: Create an array of strings, one for each line
    inputBinding:
      position: 2
      prefix: -array
outputs:
  - id: output
    type: stdout
    doc: C string version of the input
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-stringify:482--hdc0a859_1
stdout: ucsc-stringify_stringify.out
