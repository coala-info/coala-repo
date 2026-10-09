cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, info]
label: macsylib_msl_data_info
doc: "Show information about packages.\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: "the path of the alternative root directory containing package instead used canonical locations"
    inputBinding:
      position: 1
      prefix: --models-dir
  - id: model_package
    type: string
    doc: "Model Package name."
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
stdout: macsylib_msl_data_info.out
