cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmx
label: gromacs_mddb_gmx
doc: "GROMACS command-line tool\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: backup
    type:
      - 'null'
      - boolean
    doc: Write backups if output files exist
    default: yes
    inputBinding:
      position: 101
      prefix: --no-backup
  - id: copyright
    type:
      - 'null'
      - boolean
    doc: Print copyright information on startup
    inputBinding:
      position: 101
      prefix: --no-copyright
  - id: nice
    type:
      - 'null'
      - int
    doc: Set the nicelevel (default depends on command)
    default: '19'
    inputBinding:
      position: 101
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print common startup info or quotes
    inputBinding:
      position: 101
      prefix: --no-quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mddb_gmx.out
