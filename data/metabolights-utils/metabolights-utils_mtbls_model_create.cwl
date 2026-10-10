cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtbls
  - model
  - create
label: metabolights-utils_mtbls_model_create
doc: "Create the MetaboLights study model of a local study folder and save it as a JSON file.\n\nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: output_path
    type: 
      - 'null'
      - string
    doc: "Output JSON file path (default: file is created in the working directory)"
    inputBinding:
      position: 1
      prefix: --output_path
  - id: study_path
    type: Directory
    doc: "MetaboLights study folder; it should contain the ISA-Tab files, data files in the FILES subfolder"
    inputBinding:
      position: 2
outputs:
  - id: model_json
    type: File[]
    doc: "JSON file with the study model"
    outputBinding:
      glob: '*.json'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: mtbls_model_create.out
