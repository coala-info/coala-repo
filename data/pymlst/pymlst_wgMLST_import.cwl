cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - import
label: pymlst_wgMLST_import
doc: "Creates a wgMLST DATABASE from an online resource. The research can be filtered by adding a SPECIES name.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database_path
    type: string
    doc: "Name of the wgMLST database file to create"
    inputBinding:
      position: 1
  - id: species
    type: ['null', {type: array, items: string}]
    doc: "Species name used to filter the online resource"
    inputBinding:
      position: 20
  - id: force
    type: ['null', boolean]
    doc: "Overwrite already existing DATABASE"
    inputBinding:
      position: 5
      prefix: --force
  - id: prompt
    type: ['null', boolean]
    doc: "Prompt if multiple choices are found"
    inputBinding:
      position: 6
      prefix: --prompt
  - id: no_prompt
    type: ['null', boolean]
    doc: "Do not prompt if multiple choices are found, fail instead."
    inputBinding:
      position: 7
      prefix: --no-prompt
outputs:
  - id: database
    type: File
    doc: "The imported wgMLST database"
    outputBinding:
      glob: "$(inputs.database_path)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_import.out
