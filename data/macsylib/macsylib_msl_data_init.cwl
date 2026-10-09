cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, init]
label: macsylib_msl_data_init
doc: "Create a template for a new data package (requires git/GitPython)\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: model_package
    type: string
    doc: "The name of the model data package."
    inputBinding:
      position: 1
      prefix: --model-package
  - id: maintainer
    type: string
    doc: "The name of the model package maintainer."
    inputBinding:
      position: 2
      prefix: --maintainer
  - id: email
    type: string
    doc: "The email of the model package maintainer."
    inputBinding:
      position: 3
      prefix: --email
  - id: authors
    type: string
    doc: "The authors of the model package. Could be different that the maintainer. Could be several persons. Surround the names by quotes 'John Doe, Richard Miles'"
    inputBinding:
      position: 4
      prefix: --authors
  - id: license
    type:
      - 'null'
      - string
    doc: "The license under this work will be released (cc-by, cc-by-sa, cc-by-nc, cc-by-nc-sa, cc-by-nc-nd). if the license you choice is not in the list, you can do it manually by adding the license file in package and add suitable headers in model definitions."
    inputBinding:
      position: 5
      prefix: --license
  - id: holders
    type:
      - 'null'
      - string
    doc: "The holders of the copyright"
    inputBinding:
      position: 6
      prefix: --holders
  - id: desc
    type:
      - 'null'
      - string
    doc: "A short description (one line) of the package"
    inputBinding:
      position: 7
      prefix: --desc
  - id: models_dir
    type:
      - 'null'
      - string
    doc: "The path of an alternative models directory by default the package will be created here."
    inputBinding:
      position: 8
      prefix: --models-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages of the tool)
  - id: init_dir
    type:
      - 'null'
      - Directory
    doc: Folder holding the new model package template
    outputBinding:
      glob: '$(inputs.models_dir ? inputs.models_dir : null)'
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: macsylib
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_init.out
stderr: macsylib_msl_data_init.err
