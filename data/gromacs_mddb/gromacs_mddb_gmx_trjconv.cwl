cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - trjconv
label: gromacs_mddb_gmx_trjconv
doc: "gmx trjconv can convert trajectory files in many ways:\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: input_trajectory
    type: File
    doc: "Trajectory: xtc trr cpt gro g96 pdb tng"
    inputBinding:
      position: 101
      prefix: -f
  - id: structure
    type:
      - 'null'
      - File
    doc: "Structure+mass(db): tpr gro g96 pdb brk ent"
    inputBinding:
      position: 101
      prefix: -s
  - id: index_file
    type:
      - 'null'
      - File
    doc: "Index file"
    inputBinding:
      position: 101
      prefix: -n
  - id: frames_index_file
    type:
      - 'null'
      - File
    doc: "Index file"
    inputBinding:
      position: 101
      prefix: -fr
  - id: cluster_index_file
    type:
      - 'null'
      - File
    doc: "Index file"
    inputBinding:
      position: 101
      prefix: -sub
  - id: drop_xvg_file
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    inputBinding:
      position: 101
      prefix: -drop
  - id: output_trajectory
    type:
      - 'null'
      - string
    doc: "Trajectory: xtc trr gro g96 pdb tng (output file name)"
    default: trajout.xtc
    inputBinding:
      position: 101
      prefix: -o
  - id: b
    type:
      - 'null'
      - float
    doc: "Time of first frame to read from trajectory (default unit ps)"
    inputBinding:
      position: 101
      prefix: -b
  - id: e
    type:
      - 'null'
      - float
    doc: "Time of last frame to read from trajectory (default unit ps)"
    inputBinding:
      position: 101
      prefix: -e
  - id: tu
    type:
      - 'null'
      - string
    doc: "Unit for time values: fs, ps, ns, us, ms, s"
    inputBinding:
      position: 101
      prefix: -tu
  - id: w
    type:
      - 'null'
      - boolean
    doc: "View output .xvg, .xpm, .eps and .pdb files"
    inputBinding:
      position: 101
      prefix: -w
  - id: xvg
    type:
      - 'null'
      - string
    doc: "xvg plot formatting: xmgrace, xmgr, none"
    inputBinding:
      position: 101
      prefix: -xvg
  - id: skip
    type:
      - 'null'
      - int
    doc: "Only write every nr-th frame"
    inputBinding:
      position: 101
      prefix: -skip
  - id: dt
    type:
      - 'null'
      - float
    doc: "Only write frame when t MOD dt = first time (ps)"
    inputBinding:
      position: 101
      prefix: -dt
  - id: round
    type:
      - 'null'
      - boolean
    doc: "Round measurements to nearest picosecond"
    inputBinding:
      position: 101
      prefix: -round
  - id: dump
    type:
      - 'null'
      - float
    doc: "Dump frame nearest specified time (ps)"
    inputBinding:
      position: 101
      prefix: -dump
  - id: t0
    type:
      - 'null'
      - float
    doc: "Starting time (ps) (default: don't change)"
    inputBinding:
      position: 101
      prefix: -t0
  - id: timestep
    type:
      - 'null'
      - float
    doc: "Change time step between input frames (ps)"
    inputBinding:
      position: 101
      prefix: -timestep
  - id: pbc
    type:
      - 'null'
      - string
    doc: "PBC treatment (see help text for full description): none, mol, res, atom, nojump, cluster, whole"
    inputBinding:
      position: 101
      prefix: -pbc
  - id: ur
    type:
      - 'null'
      - string
    doc: "Unit-cell representation: rect, tric, compact"
    inputBinding:
      position: 101
      prefix: -ur
  - id: center
    type:
      - 'null'
      - boolean
    doc: "Center atoms in box"
    inputBinding:
      position: 101
      prefix: -center
  - id: boxcenter
    type:
      - 'null'
      - string
    doc: "Center for -pbc and -center: tric, rect, zero"
    inputBinding:
      position: 101
      prefix: -boxcenter
  - id: box
    type:
      - 'null'
      - type: array
        items: float
    doc: "Size for new cubic box (default: read from input)"
    inputBinding:
      position: 101
      prefix: -box
  - id: trans
    type:
      - 'null'
      - type: array
        items: float
    doc: "All coordinates will be translated by trans. This can advantageously be combined with -pbc mol -ur compact."
    inputBinding:
      position: 101
      prefix: -trans
  - id: shift
    type:
      - 'null'
      - type: array
        items: float
    doc: "All coordinates will be shifted by framenr*shift"
    inputBinding:
      position: 101
      prefix: -shift
  - id: fit
    type:
      - 'null'
      - string
    doc: "Fit molecule to ref structure in the structure file: none, rot+trans, rotxy+transxy, translation, transxy, progressive"
    inputBinding:
      position: 101
      prefix: -fit
  - id: ndec
    type:
      - 'null'
      - int
    doc: "Number of decimal places to write to .xtc output"
    inputBinding:
      position: 101
      prefix: -ndec
  - id: no_vel
    type:
      - 'null'
      - boolean
    doc: "Disable: Read and write velocities if possible"
    inputBinding:
      position: 101
      prefix: -novel
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Read and write forces if possible"
    inputBinding:
      position: 101
      prefix: -force
  - id: trunc
    type:
      - 'null'
      - float
    doc: "Truncate input trajectory file after this time (ps) Execute command for every output frame with the frame number as argument"
    inputBinding:
      position: 101
      prefix: -trunc
  - id: split
    type:
      - 'null'
      - float
    doc: "Start writing new file when t MOD split = first time (ps)"
    inputBinding:
      position: 101
      prefix: -split
  - id: sep
    type:
      - 'null'
      - boolean
    doc: "Write each frame to a separate .gro, .g96 or .pdb file"
    inputBinding:
      position: 101
      prefix: -sep
  - id: nzero
    type:
      - 'null'
      - int
    doc: "If the -sep flag is set, use these many digits for the file numbers and prepend zeros as needed"
    inputBinding:
      position: 101
      prefix: -nzero
  - id: dropunder
    type:
      - 'null'
      - float
    doc: "Drop all frames below this value"
    inputBinding:
      position: 101
      prefix: -dropunder
  - id: dropover
    type:
      - 'null'
      - float
    doc: "Drop all frames above this value"
    inputBinding:
      position: 101
      prefix: -dropover
  - id: conect
    type:
      - 'null'
      - boolean
    doc: "Add CONECT PDB records when writing .pdb files. Useful for visualization of non-standard molecules, e.g. coarse grained ones"
    inputBinding:
      position: 101
      prefix: -conect
  - id: selection_file
    type: File
    doc: "Text file with the group selection(s) read from standard input, one per line (e.g. 0 for System, 1 for Protein)"
outputs:
  - id: output_trajectory_out
    type: File
    doc: "Trajectory: xtc trr gro g96 pdb tng"
    outputBinding:
      glob: $(inputs.output_trajectory)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdin: $(inputs.selection_file.path)
stdout: gromacs_mddb_gmx_trjconv.out
