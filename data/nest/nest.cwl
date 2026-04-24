cwlVersion: v1.2
class: CommandLineTool
baseCommand: nest
label: nest
doc: "Read SLI code from file(s) or stdin/pipe, execute commands, or set user arguments.\n\
  \nTool homepage: http://www.nest-simulator.org/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Read SLI code from file(s) in ascending order.
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Read SLI code from stdin/pipe.
    inputBinding:
      position: 102
      prefix: --batch
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Start in debug mode (implies --verbosity=ALL)
    inputBinding:
      position: 102
      prefix: --debug
  - id: execute_cmd
    type:
      - 'null'
      - string
    doc: Execute cmd and exit
    inputBinding:
      position: 102
      prefix: -c
  - id: userargs
    type:
      - 'null'
      - type: array
        items: string
    doc: Put user defined arguments in statusdict::userargs
    inputBinding:
      position: 102
      prefix: --userargs
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Show messages of this priority and above 
      (DEBUG|STATUS|INFO|WARNING|ERROR|FATAL) or turn off all messages (QUIET).
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nest:2.14.0--py36_2
stdout: nest.out
