cwlVersion: v1.2
class: CommandLineTool
baseCommand: socru_species
label: socru_species
doc: "List all available species\n\nTool homepage: https://github.com/quadram-institute-bioscience/socru"
inputs:
  - id: extended
    type:
      - 'null'
      - boolean
    doc: Extended information about the species databases
    inputBinding:
      position: 103
      prefix: --extended
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 103
      prefix: --debug
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Species list
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
stdout: socru_species.out
