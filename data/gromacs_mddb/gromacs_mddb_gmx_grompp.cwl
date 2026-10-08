cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - grompp
label: gromacs_mddb_gmx_grompp
doc: "gmx grompp (the gromacs preprocessor) reads a molecular topology file, checks the validity of the file, expands the topology from a molecular description to an atomic description. The topology file contains information about molecule types and the number of molecules, the preprocessor copies each molecule as needed. There is no limitation on the number of molecule types. Bonds and bond-angles can be converted into constraints, separately for hydrogens and heavy atoms. Then a coordinate file is read and velocities can be generated from a Maxwellian distribution if requested. gmx grompp also reads parameters for gmx mdrun (eg. number of MD steps, time step, cut-off). Eventually a binary file is produced that can serve as the sole input file for the MD program.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: input_mdp
    type: File
    doc: "grompp input file with MD parameters"
    inputBinding:
      position: 101
      prefix: -f
  - id: input_structure
    type: File
    doc: "Structure file: gro g96 pdb brk ent esp tpr"
    inputBinding:
      position: 101
      prefix: -c
  - id: restraint_structure_a
    type:
      - 'null'
      - File
    doc: "Structure file: gro g96 pdb brk ent esp tpr"
    inputBinding:
      position: 101
      prefix: -r
  - id: restraint_structure_b
    type:
      - 'null'
      - File
    doc: "Structure file: gro g96 pdb brk ent esp tpr"
    inputBinding:
      position: 101
      prefix: -rb
  - id: index_file
    type:
      - 'null'
      - File
    doc: "Index file"
    inputBinding:
      position: 101
      prefix: -n
  - id: topology_file
    type: File
    doc: "Topology file"
    inputBinding:
      position: 101
      prefix: -p
  - id: trajectory_file
    type:
      - 'null'
      - File
    doc: "Full precision trajectory: trr cpt tng"
    inputBinding:
      position: 101
      prefix: -t
  - id: energy_file
    type:
      - 'null'
      - File
    doc: "Energy file"
    inputBinding:
      position: 101
      prefix: -e
  - id: qmmm_input
    type:
      - 'null'
      - File
    doc: "Input file for QM program"
    inputBinding:
      position: 101
      prefix: -qmi
  - id: reference_trajectory
    type:
      - 'null'
      - File
    doc: "Full precision trajectory: trr cpt tng"
    inputBinding:
      position: 101
      prefix: -ref
  - id: output_mdp
    type:
      - 'null'
      - string
    doc: "grompp input file with MD parameters (output file name)"
    default: mdout.mdp
    inputBinding:
      position: 101
      prefix: -po
  - id: processed_topology
    type:
      - 'null'
      - string
    doc: "Topology file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -pp
  - id: output_tpr
    type:
      - 'null'
      - string
    doc: "Portable xdr run input file (output file name)"
    default: topol.tpr
    inputBinding:
      position: 101
      prefix: -o
  - id: output_imd
    type:
      - 'null'
      - string
    doc: "Coordinate file in Gromos-87 format (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -imd
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Be loud and noisy"
    inputBinding:
      position: 101
      prefix: -v
  - id: time
    type:
      - 'null'
      - float
    doc: "Take frame at or first after this time."
    inputBinding:
      position: 101
      prefix: -time
  - id: no_remove_virtual_site_bonds
    type:
      - 'null'
      - boolean
    doc: "Disable: Remove constant bonded interactions with virtual sites"
    inputBinding:
      position: 101
      prefix: -normvsbds
  - id: max_warnings
    type:
      - 'null'
      - int
    doc: "Number of allowed warnings during input processing. Not for normal use and may generate unstable systems"
    inputBinding:
      position: 101
      prefix: -maxwarn
  - id: set_zero_defaults
    type:
      - 'null'
      - boolean
    doc: "Set parameters for bonded interactions without defaults to zero instead of generating an error"
    inputBinding:
      position: 101
      prefix: -zero
  - id: no_renumber_atomtypes
    type:
      - 'null'
      - boolean
    doc: "Disable: Renumber atomtypes and minimize number of atomtypes"
    inputBinding:
      position: 101
      prefix: -norenum
  - id: include_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files included by the topology (.itp, position restraints) staged beside the inputs"
outputs:
  - id: output_mdp_out
    type: File
    doc: "grompp input file with MD parameters"
    outputBinding:
      glob: $(inputs.output_mdp)
  - id: processed_topology_out
    type:
      - 'null'
      - File
    doc: "Topology file"
    outputBinding:
      glob: $(inputs.processed_topology)
  - id: output_tpr_out
    type: File
    doc: "Portable xdr run input file"
    outputBinding:
      glob: $(inputs.output_tpr)
  - id: output_imd_out
    type:
      - 'null'
      - File
    doc: "Coordinate file in Gromos-87 format"
    outputBinding:
      glob: $(inputs.output_imd)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.include_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mddb_gmx_grompp.out
