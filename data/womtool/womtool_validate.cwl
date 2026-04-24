cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar womtool.jar
label: womtool_validate
doc: "A tool for validating and manipulating WDL workflows.\n\nTool homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., validate, inputs, outputs, parse, 
      highlight, graph, upgrade, womgraph)
    inputBinding:
      position: 1
  - id: workflow_source
    type: File
    doc: Path to workflow file.
    inputBinding:
      position: 2
  - id: highlight_mode
    type:
      - 'null'
      - string
    doc: Highlighting mode, one of 'html', 'console' (used only with 'highlight'
      command)
    inputBinding:
      position: 103
      prefix: --highlight-mode
  - id: inputs_file
    type:
      - 'null'
      - File
    doc: Workflow inputs file.
    inputBinding:
      position: 103
      prefix: --inputs
  - id: list_dependencies
    type:
      - 'null'
      - boolean
    doc: An optional flag to list files referenced in import statements (used 
      only with 'validate' command)
    inputBinding:
      position: 103
      prefix: --list-dependencies
  - id: optional_inputs
    type:
      - 'null'
      - boolean
    doc: If set, optional inputs are also included in the inputs set. Default is
      'true' (used only with the inputs command)
    inputBinding:
      position: 103
      prefix: --optional-inputs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/womtool:61--hdfd78af_0
stdout: womtool_validate.out
