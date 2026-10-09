cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, available]
label: macsylib_msl_data_available
doc: "List Models available on macsy-models\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: org
    type:
      - 'null'
      - string
    doc: "The name of Model organization (default 'macsy-models')"
    inputBinding:
      position: 1
      prefix: --org
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_available.out
