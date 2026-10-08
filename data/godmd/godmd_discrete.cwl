cwlVersion: v1.2
class: CommandLineTool
baseCommand: discrete
label: godmd_discrete
doc: "GOdMD discrete molecular dynamics: drives an initial PDB structure towards a target PDB structure with a Go-like potential.\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/adam/GOdMD"
inputs:
  - id: settings
    type: File
    doc: Settings (parameter file with the &INPUT namelist, for example TSNAP,
      NBLOC, TEMP, seed)
    inputBinding:
      position: 101
      prefix: -i
  - id: initial_pdb
    type: File
    doc: Initial PDB (raw PDB file)
    inputBinding:
      position: 101
      prefix: -pdbin
  - id: target_pdb
    type: File
    doc: Target PDB
    inputBinding:
      position: 101
      prefix: -pdbtarg
  - id: trajectory_pdb
    type:
      - 'null'
      - string
    doc: Name of the output trajectory (PDB)
    inputBinding:
      position: 101
      prefix: -trj
  - id: energies
    type:
      - 'null'
      - string
    doc: Name of the output energies file
    inputBinding:
      position: 101
      prefix: -ener
  - id: calculation_log
    type:
      - 'null'
      - string
    doc: Name of the calculation log file
    inputBinding:
      position: 101
      prefix: -o
  - id: same_residues_table
    type: File
    doc: Alignment table of same residues for the initial structure (required, for example 2lao_A.aln)
    inputBinding:
      position: 101
      prefix: -p1
  - id: same_residues_target_table
    type: File
    doc: Alignment table of same residues for the target structure (required, for example 1lst_A.aln)
    inputBinding:
      position: 101
      prefix: -p2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: trajectory
    type:
      - 'null'
      - File
    doc: Output trajectory (PDB)
    outputBinding:
      glob: "$(inputs.trajectory_pdb ? inputs.trajectory_pdb : 'no_trajectory')"
  - id: energies_file
    type:
      - 'null'
      - File
    doc: Output energies
    outputBinding:
      glob: "$(inputs.energies ? inputs.energies : 'no_energies')"
  - id: log_file
    type:
      - 'null'
      - File
    doc: Calculation log
    outputBinding:
      glob: "$(inputs.calculation_log ? inputs.calculation_log : 'no_log')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/godmd:1.8--hb569540_0
stdout: godmd_discrete.out
