cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - rm
label: fiona_fio_rm
doc: "Remove a datasource or an individual layer.\n\nTool homepage: https://github.com/Toblerity/Fiona"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
inputs:
  - id: input
    type: File
    doc: Datasource to modify (staged as a writable copy; the result is returned as an output)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: layer
    type:
      - 'null'
      - string
    doc: Name of layer to remove.
    inputBinding:
      position: 102
      prefix: --layer
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Do not ask for confirmation.
    inputBinding:
      position: 102
      prefix: --yes
outputs:
  - id: modified_datasource
    type:
      - 'null'
      - File
    doc: The datasource after removal (absent when the whole datasource was removed)
    outputBinding:
      glob: $(inputs.input.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
