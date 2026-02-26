cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-parsec_parsec
label: galaxy-parsec_parsec init
doc: "Initialize Galaxy parsec connection.\n\nTool homepage: https://github.com/galaxy-iuc/parsec"
inputs:
  - id: galaxy_url
    type: string
    doc: Galaxy's URL
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-parsec:1.16.0--pyh5e36f6f_0
stdout: galaxy-parsec_parsec init.out
