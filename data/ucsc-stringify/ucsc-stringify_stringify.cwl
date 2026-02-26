cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringify
label: ucsc-stringify_stringify
doc: "Convert file to C strings\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input file to convert
    inputBinding:
      position: 1
  - id: array_of_strings
    type:
      - 'null'
      - boolean
    doc: Create an array of strings, one for each line
    inputBinding:
      position: 102
      prefix: --array
  - id: static_variable
    type:
      - 'null'
      - boolean
    doc: Create the variable but put static in front of it.
    inputBinding:
      position: 102
      prefix: --static
  - id: variable_name
    type:
      - 'null'
      - string
    doc: Create a variable with the specified name containing the string.
    inputBinding:
      position: 102
      prefix: --var
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-stringify:482--hdc0a859_1
stdout: ucsc-stringify_stringify.out
