cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - trjconv
label: gromacs_mddb_gmx trjconv
doc: "gmx trjconv can convert trajectory files in many ways:\n\n* from one format
  to another\n* select a subset of atoms\n* change the periodicity representation\n\
  * keep multimeric molecules together\n* center atoms in the box\n* fit atoms to
  reference structure\n* reduce the number of frames\n* change the timestamps of the
  frames (-t0 and -timestep)\n* select frames within a certain range of a quantity
  given in an .xvg file.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: add_conect_pdb
    type:
      - 'null'
      - boolean
    doc: "Add CONECT PDB records when writing .pdb files. Useful for\n           visualization
      of non-standard molecules, e.g. coarse grained ones"
    default: false
    inputBinding:
      position: 101
      prefix: -conect
  - id: box_center_type
    type:
      - 'null'
      - string
    doc: 'Center for -pbc and -center: tric, rect, zero'
    default: tric
    inputBinding:
      position: 101
      prefix: -boxcenter
  - id: center_atoms
    type:
      - 'null'
      - boolean
    doc: Center atoms in box
    default: false
    inputBinding:
      position: 101
      prefix: -center
  - id: change_timestep
    type:
      - 'null'
      - string
    doc: Change time step between input frames (ps)
    default: 0
    inputBinding:
      position: 101
      prefix: -timestep
  - id: cluster_index_file
    type:
      - 'null'
      - File
    doc: Index file
    inputBinding:
      position: 101
      prefix: -sub
  - id: drop_over_value
    type:
      - 'null'
      - string
    doc: Drop all frames above this value
    default: 0
    inputBinding:
      position: 101
      prefix: -dropover
  - id: drop_under_value
    type:
      - 'null'
      - string
    doc: Drop all frames below this value
    default: 0
    inputBinding:
      position: 101
      prefix: -dropunder
  - id: drop_xvg_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -drop
  - id: dt_write
    type:
      - 'null'
      - string
    doc: Only write frame when t MOD dt = first time (ps)
    default: 0
    inputBinding:
      position: 101
      prefix: -dt
  - id: dump_time
    type:
      - 'null'
      - string
    doc: Dump frame nearest specified time (ps)
    default: -1
    inputBinding:
      position: 101
      prefix: -dump
  - id: end_time
    type:
      - 'null'
      - string
    doc: Time of last frame to read from trajectory (default unit ps)
    default: 0
    inputBinding:
      position: 101
      prefix: -e
  - id: execute_command
    type:
      - 'null'
      - string
    doc: "Execute command for every output frame with the frame number as\n      \
      \     argument"
    inputBinding:
      position: 101
      prefix: -exec
  - id: fit_method
    type:
      - 'null'
      - string
    doc: "Fit molecule to ref structure in the structure file: none,\n           rot+trans,
      rotxy+transxy, translation, transxy, progressive"
    default: none
    inputBinding:
      position: 101
      prefix: -fit
  - id: frames_index_file
    type:
      - 'null'
      - File
    doc: Index file
    inputBinding:
      position: 101
      prefix: -fr
  - id: index_file
    type:
      - 'null'
      - File
    doc: Index file
    inputBinding:
      position: 101
      prefix: -n
  - id: input_trajectory
    type:
      - 'null'
      - File
    doc: 'Trajectory: xtc trr cpt gro g96 pdb tng'
    inputBinding:
      position: 101
      prefix: -f
  - id: new_box_size
    type:
      - 'null'
      - string
    doc: 'Size for new cubic box (default: read from input)'
    default: 0 0 0
    inputBinding:
      position: 101
      prefix: -box
  - id: no_add_conect_pdb
    type:
      - 'null'
      - boolean
    doc: "Add CONECT PDB records when writing .pdb files. Useful for\n           visualization
      of non-standard molecules, e.g. coarse grained ones"
    default: true
    inputBinding:
      position: 101
      prefix: -noconect
  - id: no_center_atoms
    type:
      - 'null'
      - boolean
    doc: Center atoms in box
    default: true
    inputBinding:
      position: 101
      prefix: -nocenter
  - id: no_round_measurements
    type:
      - 'null'
      - boolean
    doc: Round measurements to nearest picosecond
    default: true
    inputBinding:
      position: 101
      prefix: -noround
  - id: no_write_forces
    type:
      - 'null'
      - boolean
    doc: Read and write forces if possible
    default: true
    inputBinding:
      position: 101
      prefix: -noforce
  - id: no_write_output
    type:
      - 'null'
      - boolean
    doc: View output .xvg, .xpm, .eps and .pdb files
    default: true
    inputBinding:
      position: 101
      prefix: -now
  - id: no_write_separate_files
    type:
      - 'null'
      - boolean
    doc: Write each frame to a separate .gro, .g96 or .pdb file
    default: true
    inputBinding:
      position: 101
      prefix: -nosep
  - id: no_write_velocities
    type:
      - 'null'
      - boolean
    doc: Read and write velocities if possible
    default: false
    inputBinding:
      position: 101
      prefix: -novel
  - id: num_digits_for_sep_files
    type:
      - 'null'
      - int
    doc: "If the -sep flag is set, use these many digits for the file numbers\n  \
      \         and prepend zeros as needed"
    default: 0
    inputBinding:
      position: 101
      prefix: -nzero
  - id: pbc_treatment
    type:
      - 'null'
      - string
    doc: 'PBC treatment (see help text for full description): none, mol, res, atom,
      nojump, cluster, whole'
    default: none
    inputBinding:
      position: 101
      prefix: -pbc
  - id: round_measurements
    type:
      - 'null'
      - boolean
    doc: Round measurements to nearest picosecond
    default: false
    inputBinding:
      position: 101
      prefix: -round
  - id: shift_vector
    type:
      - 'null'
      - string
    doc: All coordinates will be shifted by framenr*shift
    default: 0 0 0
    inputBinding:
      position: 101
      prefix: -shift
  - id: skip_frames
    type:
      - 'null'
      - int
    doc: Only write every nr-th frame
    default: 1
    inputBinding:
      position: 101
      prefix: -skip
  - id: split_time
    type:
      - 'null'
      - string
    doc: Start writing new file when t MOD split = first time (ps)
    default: 0
    inputBinding:
      position: 101
      prefix: -split
  - id: start_time
    type:
      - 'null'
      - string
    doc: Time of first frame to read from trajectory (default unit ps)
    default: 0
    inputBinding:
      position: 101
      prefix: -b
  - id: start_time_offset
    type:
      - 'null'
      - string
    doc: "Starting time (ps) (default: don't change)"
    default: 0
    inputBinding:
      position: 101
      prefix: -t0
  - id: structure
    type:
      - 'null'
      - File
    doc: 'Structure+mass(db): tpr gro g96 pdb brk ent'
    inputBinding:
      position: 101
      prefix: -s
  - id: time_unit
    type:
      - 'null'
      - string
    doc: 'Unit for time values: fs, ps, ns, us, ms, s'
    default: ps
    inputBinding:
      position: 101
      prefix: -tu
  - id: translation_vector
    type:
      - 'null'
      - string
    doc: "All coordinates will be translated by trans. This can\n           advantageously
      be combined with -pbc mol -ur compact."
    default: 0 0 0
    inputBinding:
      position: 101
      prefix: -trans
  - id: truncate_time
    type:
      - 'null'
      - string
    doc: Truncate input trajectory file after this time (ps)
    default: -1
    inputBinding:
      position: 101
      prefix: -trunc
  - id: unit_cell_representation
    type:
      - 'null'
      - string
    doc: 'Unit-cell representation: rect, tric, compact'
    default: rect
    inputBinding:
      position: 101
      prefix: -ur
  - id: write_forces
    type:
      - 'null'
      - boolean
    doc: Read and write forces if possible
    default: false
    inputBinding:
      position: 101
      prefix: -force
  - id: write_output
    type:
      - 'null'
      - boolean
    doc: View output .xvg, .xpm, .eps and .pdb files
    default: false
    inputBinding:
      position: 101
      prefix: -w
  - id: write_separate_files
    type:
      - 'null'
      - boolean
    doc: Write each frame to a separate .gro, .g96 or .pdb file
    default: false
    inputBinding:
      position: 101
      prefix: -sep
  - id: write_velocities
    type:
      - 'null'
      - boolean
    doc: Read and write velocities if possible
    default: true
    inputBinding:
      position: 101
      prefix: -vel
  - id: xtc_output_precision
    type:
      - 'null'
      - int
    doc: Number of decimal places to write to .xtc output
    default: 3
    inputBinding:
      position: 101
      prefix: -ndec
  - id: xvg_plot_formatting
    type:
      - 'null'
      - string
    doc: 'xvg plot formatting: xmgrace, xmgr, none'
    default: xmgrace
    inputBinding:
      position: 101
      prefix: -xvg
outputs:
  - id: output_trajectory
    type:
      - 'null'
      - File
    doc: 'Trajectory: xtc trr gro g96 pdb tng'
    outputBinding:
      glob: $(inputs.output_trajectory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
