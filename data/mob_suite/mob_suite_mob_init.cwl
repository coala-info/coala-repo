cwlVersion: v1.2
class: CommandLineTool
baseCommand: mob_init
label: mob_suite_mob_init
doc: "MOB-INIT: initialize databases\n\nTool homepage: https://github.com/phac-nml/mob-suite"
inputs:
  - id: database_directory
    type:
      - 'null'
      - Directory
    doc: Directory to download databases to.
    default: /usr/local/lib/python3.11/site-packages/mob_suite/databases
    inputBinding:
      position: 101
      prefix: --database_directory
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Set the verbosity level. Can by used multiple times
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mob_suite:3.1.9--pyhdfd78af_1
stdout: mob_suite_mob_init.out
