cwlVersion: v1.2
class: CommandLineTool
baseCommand: ost
label: openstructure_ost
doc: "OpenStructure command-line interface\n\nTool homepage: https://openstructure.org"
inputs:
  - id: action_name
    type:
      - 'null'
      - string
    doc: action name
    inputBinding:
      position: 1
  - id: script_to_execute
    type:
      - 'null'
      - string
    doc: script to execute
    inputBinding:
      position: 2
  - id: action_options
    type:
      - 'null'
      - type: array
        items: string
    doc: action options
    inputBinding:
      position: 3
  - id: script_parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: script parameters
    inputBinding:
      position: 4
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: start interpreter interactively (must be first parameter, ignored 
      otherwise)
    inputBinding:
      position: 105
      prefix: --interactive
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: sets the verbosity level
    inputBinding:
      position: 105
      prefix: --verbosity_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openstructure:2.11.1--py310h1f7f436_0
stdout: openstructure_ost.out
