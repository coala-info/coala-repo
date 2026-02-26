cwlVersion: v1.2
class: CommandLineTool
baseCommand: olivar save
label: olivar_save
doc: "Saves an Olivar design to a file.\n\nTool homepage: https://gitlab.com/treangenlab/olivar"
inputs:
  - id: olvd_file
    type: File
    doc: Path to the Olivar design file (.olvd)
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output path (output to current directory by default).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
