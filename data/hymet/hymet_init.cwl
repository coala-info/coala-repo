cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet_init
label: hymet_init
doc: "Initialize hymet project\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't exit with error on missing files
    inputBinding:
      position: 101
      prefix: --quiet
  - id: skip_taxonomy
    type:
      - 'null'
      - boolean
    doc: Skip automatic NCBI taxonomy download
    inputBinding:
      position: 101
      prefix: --skip-taxonomy
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
stdout: hymet_init.out
