cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmx
label: gromacs_py_gmx
doc: "GROMACS command-line interface. Use 'gmx help' for more information.\n\nTool
  homepage: https://github.com/samuelmurail/gromacs_py"
inputs:
  - id: backup
    type:
      - 'null'
      - boolean
    doc: Write backups if output files exist
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
    inputBinding:
      position: 101
      prefix: -nice
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
stdout: gromacs_py_gmx.out
