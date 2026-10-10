cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mtbls
  - model
  - explain
label: metabolights-utils_mtbls_model_explain
doc: "Explain properties and sub-properties of the MetaboLights study model.\n\nTool homepage: https://github.com/EBI-Metabolights/metabolights-utils"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: model_pattern
    type: 
      - 'null'
      - string
    doc: "Property path of the study model to explain, e.g. investigation, investigation.studies, assays.assay_technique (root properties are listed if not given)"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabolights-utils:1.4.18--pyhdfd78af_0
stdout: mtbls_model_explain.out
