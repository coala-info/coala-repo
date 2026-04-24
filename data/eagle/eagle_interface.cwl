cwlVersion: v1.2
class: CommandLineTool
baseCommand: eagle interface
label: eagle_interface
doc: "Starts the EAGLE web interface.\n\nTool homepage: https://bitbucket.org/christopherschroeder/eagle"
inputs:
  - id: config
    type: File
    doc: config file to use.
    inputBinding:
      position: 101
      prefix: --config
  - id: nodebug
    type:
      - 'null'
      - boolean
    doc: disable debug messages
    inputBinding:
      position: 101
      prefix: --nodebug
  - id: port
    type:
      - 'null'
      - int
    doc: port
    inputBinding:
      position: 101
      prefix: --port
  - id: processes
    type:
      - 'null'
      - int
    doc: use up to M parallel processes to serve HTTP requests
    inputBinding:
      position: 101
      prefix: --processes
  - id: public
    type:
      - 'null'
      - boolean
    doc: listen for external connections
    inputBinding:
      position: 101
      prefix: --public
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eagle:0.9.4.6--pyh5ca1d4c_0
stdout: eagle_interface.out
