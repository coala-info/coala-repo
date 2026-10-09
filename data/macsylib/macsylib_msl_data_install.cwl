cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, install]
label: macsylib_msl_data_install
doc: "Install Model packages.\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Reinstall Model package even if it is already up-to-date."
    inputBinding:
      position: 1
      prefix: --force
  - id: org
    type:
      - 'null'
      - string
    doc: "The name of Model organization (default 'macsy-models')"
    inputBinding:
      position: 2
      prefix: --org
  - id: user
    type:
      - 'null'
      - boolean
    doc: "Install for the user install directory for your platform. Typically ~/.macsylib/data"
    inputBinding:
      position: 3
      prefix: --user
  - id: target
    type:
      - 'null'
      - string
    doc: "Install packages into <TARGET> dir instead in canonical location"
    inputBinding:
      position: 3
      prefix: --target
  - id: upgrade
    type:
      - 'null'
      - boolean
    doc: "Upgrade specified package to the newest available version."
    inputBinding:
      position: 4
      prefix: --upgrade
  - id: model_package
    type: string
    doc: "Model Package name."
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages of the tool)
  - id: target_dir
    type:
      - 'null'
      - Directory
    doc: Folder with the installed model package
    outputBinding:
      glob: $(inputs.target)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_install.out
stderr: macsylib_msl_data_install.err
