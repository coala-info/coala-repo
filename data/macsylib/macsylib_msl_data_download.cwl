cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, download]
label: macsylib_msl_data_download
doc: "Download model packages.\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: dest
    type:
      - 'null'
      - string
    doc: "Download model packages into <dir>."
    inputBinding:
      position: 1
      prefix: --dest
  - id: org
    type:
      - 'null'
      - string
    doc: "The name of Model organization (default 'macsy-models')"
    inputBinding:
      position: 2
      prefix: --org
  - id: model_package
    type: string
    doc: "Model package name."
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: dest_dir
    type:
      - 'null'
      - Directory
    doc: Folder with the downloaded model package
    outputBinding:
      glob: $(inputs.dest)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_download.out
