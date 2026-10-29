cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - setup
label: gget_setup
doc: 'Install third-party dependencies for a specified gget module.


  Tool homepage: https://github.com/pachterlab/gget'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: module
    type:
      type: enum
      symbols:
        - alphafold
        - gpt
        - cellxgene
        - elm
        - cbio
    doc: gget module for which dependencies should be installed, e.g. 'alphafold'.
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: out_path
    type:
      - 'null'
      - string
    doc: 'Path to folder where downloaded files are saved (currently only applies when module is elm). Default: files are saved inside the gget installation folder.'
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Folder with the downloaded files (elm module only).
    outputBinding:
      glob: $(inputs.out_path)
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Progress messages
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
stdout: gget_setup.out
stderr: gget_setup.log
