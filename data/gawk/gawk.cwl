cwlVersion: v1.2
class: CommandLineTool
baseCommand: gawk
label: gawk
doc: "pattern scanning and processing language\n\nTool homepage: https://www.gnu.org/software/gawk/"
inputs:
  - id: program_text
    type:
      - 'null'
      - string
    doc: AWK program source code (if -f is not specified).
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to be processed.
    inputBinding:
      position: 2
  - id: assign
    type:
      - 'null'
      - type: array
        items: string
    doc: Assign the value val to the variable var, before execution of the program
      begins.
    inputBinding:
      position: 103
      prefix: --assign
  - id: field_separator
    type:
      - 'null'
      - string
    doc: Use fs for the input field separator (the value of the FS predefined variable).
    inputBinding:
      position: 103
      prefix: --field-separator
  - id: program_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Read the AWK program source from the file program-file, instead of from the
      first command line argument.
    inputBinding:
      position: 103
      prefix: --file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gawk:5.3.1
stdout: gawk.out
