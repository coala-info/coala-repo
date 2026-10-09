cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, show]
label: macsylib_msl_data_show
doc: "show the structure of model package\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
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
    type: string
    doc: "a model package name eg: TXSScan or CasFinder"
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
stdout: macsylib_msl_data_show.out
