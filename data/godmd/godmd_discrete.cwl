cwlVersion: v1.2
class: CommandLineTool
baseCommand: godmd_discrete
label: godmd_discrete
doc: "Settings\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/adam/GOdMD"
inputs:
  - id: calculation_log
    type:
      - 'null'
      - string
    doc: Calculation Log
    inputBinding:
      position: 101
      prefix: -o
  - id: energies
    type:
      - 'null'
      - string
    doc: Energies
    inputBinding:
      position: 101
      prefix: -ener
  - id: initial_pdb
    type:
      - 'null'
      - File
    doc: Initial PDB
    inputBinding:
      position: 101
      prefix: -pdbin
  - id: same_residues_table
    type:
      - 'null'
      - File
    doc: Table of same residues
    inputBinding:
      position: 101
      prefix: -p1
  - id: same_residues_target_table
    type:
      - 'null'
      - File
    doc: Table of same residues target
    inputBinding:
      position: 101
      prefix: -p2
  - id: settings
    type:
      - 'null'
      - string
    doc: Settings
    inputBinding:
      position: 101
      prefix: -i
  - id: target_pdb
    type:
      - 'null'
      - File
    doc: Target PDB
    inputBinding:
      position: 101
      prefix: -pdbtarg
  - id: trajectory_pdb
    type:
      - 'null'
      - File
    doc: Trajectory (PDB)
    inputBinding:
      position: 101
      prefix: -trj
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/godmd:1.8--hb569540_0
stdout: godmd_discrete.out
