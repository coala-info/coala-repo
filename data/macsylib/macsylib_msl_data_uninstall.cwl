cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, uninstall]
label: macsylib_msl_data_uninstall
doc: "Uninstall packages.\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: "the path of the alternative root directory containing package instead used canonical locations"
    inputBinding:
      position: 1
      prefix: --target
      valueFrom: "$(self.basename)"
  - id: model_package
    type: string
    doc: "ModelPackage name."
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages of the tool)
  - id: models_dir_out
    type:
      - 'null'
      - Directory
    doc: Models folder after the uninstall
    outputBinding:
      glob: '$(inputs.models_dir ? inputs.models_dir.basename : null)'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.models_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_uninstall.out
stderr: macsylib_msl_data_uninstall.err
