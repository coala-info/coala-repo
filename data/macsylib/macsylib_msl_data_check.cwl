cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, check]
label: macsylib_msl_data_check
doc: "check if the directory is ready to be publish as data package\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: grammar
    type:
      - 'null'
      - string
    doc: "The version of the target grammar (2.0 or 2.1). For the grammar '2.0' only basic checking is performed. For thorough checking choose '2.1'. (default: '2.1')"
    inputBinding:
      position: 1
      prefix: --grammar
  - id: path
    type:
      - 'null'
      - Directory
    doc: "the path to root directory models to check"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages of the tool)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_check.out
stderr: macsylib_msl_data_check.err
successCodes: [0, 1]
