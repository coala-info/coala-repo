cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdi
label: genomics-data-index_gdi_init
doc: "Initialize an empty project folder for the genomics data index.\n\nThe tool needs a project folder made by \"gdi init\". It is passed as project_dir.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
arguments:
  - position: 3
    valueFrom: init
inputs:
  - id: project_dir
    type: string
    doc: "New project folder to create"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: project_dir_out
    type:
      - 'null'
      - Directory
    doc: "The new project folder"
    outputBinding:
      glob: $(inputs.project_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: gdi
      - envName: QT_QPA_PLATFORM
        envValue: offscreen
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi_init.out
