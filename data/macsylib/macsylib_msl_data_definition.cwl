cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, definition]
label: macsylib_msl_data_definition
doc: "show a model definition\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: "the path to the alternative root directory containing packages instead to the canonical locations"
    inputBinding:
      position: 1
      prefix: --models-dir
  - id: model
    type:
      - type: array
        items: string
    doc: "the family and name(s) of a model(s) eg: TXSS T6SS T4SS or TFF/bacterial T2SS"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_definition.out
