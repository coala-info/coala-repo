cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - grompp
label: gromacs_mddb_gmx grompp
doc: "reads a molecular topology file, checks the validity of the file, expands the
  topology from a molecular description to an atomic description. The topology file
  contains information about molecule types and the number of molecules, the preprocessor
  copies each molecule as needed. There is no limitation on the number of molecule
  types. Bonds and bond-angles can be converted into constraints, separately for hydrogens
  and heavy atoms. Then a coordinate file is read and velocities can be generated
  from a Maxwellian distribution if requested. gmx grompp also reads parameters for
  gmx mdrun (eg. number of MD steps, time step, cut-off). Eventually a binary file
  is produced that can serve as the sole input file for the MD program.\n\nTool homepage:
  https://www.gromacs.org/"
inputs:
  - id: energy_file
    type:
      - 'null'
      - File
    doc: Energy file
    default: ener.edr
    inputBinding:
      position: 101
      prefix: -e
  - id: index_file
    type:
      - 'null'
      - File
    doc: Index file
    default: index.ndx
    inputBinding:
      position: 101
      prefix: -n
  - id: input_mdp
    type:
      - 'null'
      - File
    doc: grompp input file with MD parameters
    default: grompp.mdp
    inputBinding:
      position: 101
      prefix: -f
  - id: input_structure
    type:
      - 'null'
      - File
    doc: 'Structure file: gro g96 pdb brk ent esp tpr'
    default: conf.gro
    inputBinding:
      position: 101
      prefix: -c
  - id: max_warnings
    type:
      - 'null'
      - int
    doc: "Number of allowed warnings during input processing. Not for normal\n   \
      \        use and may generate unstable systems"
    default: 0
    inputBinding:
      position: 101
      prefix: -maxwarn
  - id: no_remove_virtual_site_bonds
    type:
      - 'null'
      - boolean
    default: false
    inputBinding:
      position: 101
      prefix: --no-rmvsbds
  - id: no_renumber_atomtypes
    type:
      - 'null'
      - boolean
    default: false
    inputBinding:
      position: 101
      prefix: --no-renum
  - id: no_set_zero_defaults
    type:
      - 'null'
      - boolean
    default: true
    inputBinding:
      position: 101
      prefix: --no-zero
  - id: no_verbose
    type:
      - 'null'
      - boolean
    default: true
    inputBinding:
      position: 101
      prefix: --no-v
  - id: qmmm_input
    type:
      - 'null'
      - File
    doc: Input file for QM program
    default: topol-qmmm.inp
    inputBinding:
      position: 101
      prefix: -qmi
  - id: reference_trajectory
    type:
      - 'null'
      - File
    doc: 'Full precision trajectory: trr cpt tng'
    default: rotref.trr
    inputBinding:
      position: 101
      prefix: -ref
  - id: remove_virtual_site_bonds
    type:
      - 'null'
      - boolean
    default: true
    inputBinding:
      position: 101
      prefix: --rmvsbds
  - id: renumber_atomtypes
    type:
      - 'null'
      - boolean
    default: true
    inputBinding:
      position: 101
      prefix: --renum
  - id: restraint_structure_a
    type:
      - 'null'
      - File
    doc: 'Structure file: gro g96 pdb brk ent esp tpr'
    default: restraint.gro
    inputBinding:
      position: 101
      prefix: -r
  - id: restraint_structure_b
    type:
      - 'null'
      - File
    doc: 'Structure file: gro g96 pdb brk ent esp tpr'
    default: restraint.gro
    inputBinding:
      position: 101
      prefix: -rb
  - id: set_zero_defaults
    type:
      - 'null'
      - boolean
    default: false
    inputBinding:
      position: 101
      prefix: --zero
  - id: time
    type:
      - 'null'
      - float
    doc: Take frame at or first after this time.
    default: -1.0
    inputBinding:
      position: 101
  - id: topology_file
    type:
      - 'null'
      - File
    doc: Topology file
    default: topol.top
    inputBinding:
      position: 101
      prefix: -p
  - id: trajectory_file
    type:
      - 'null'
      - File
    doc: 'Full precision trajectory: trr cpt tng'
    default: traj.trr
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    default: false
    inputBinding:
      position: 101
      prefix: --v
outputs:
  - id: output_mdp
    type:
      - 'null'
      - File
    doc: grompp input file with MD parameters
    outputBinding:
      glob: $(inputs.output_mdp)
  - id: processed_topology
    type:
      - 'null'
      - File
    doc: Topology file
    outputBinding:
      glob: $(inputs.processed_topology)
  - id: output_tpr
    type:
      - 'null'
      - File
    doc: Portable xdr run input file
    outputBinding:
      glob: $(inputs.output_tpr)
  - id: output_imd
    type:
      - 'null'
      - File
    doc: Coordinate file in Gromos-87 format
    outputBinding:
      glob: $(inputs.output_imd)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
