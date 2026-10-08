cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - dump
label: gromacs_mddb_gmx_dump
doc: "gmx dump reads a run input file (.tpr), a trajectory (.trr/.xtc/tng), an energy file (.edr), a checkpoint file (.cpt) or topology file (.top) and prints that to standard output in a readable format. This program is essential for checking your run input file in case of problems.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: run_input_file
    type:
      - 'null'
      - File
    doc: "Run input file to dump"
    inputBinding:
      position: 101
      prefix: -s
  - id: trajectory_file
    type:
      - 'null'
      - File
    doc: "Trajectory file to dump: xtc trr cpt gro g96 pdb tng"
    inputBinding:
      position: 101
      prefix: -f
  - id: energy_file
    type:
      - 'null'
      - File
    doc: "Energy file to dump"
    inputBinding:
      position: 101
      prefix: -e
  - id: checkpoint_file
    type:
      - 'null'
      - File
    doc: "Checkpoint file to dump"
    inputBinding:
      position: 101
      prefix: -cp
  - id: topology_file
    type:
      - 'null'
      - File
    doc: "Topology file to dump"
    inputBinding:
      position: 101
      prefix: -p
  - id: hessian_matrix
    type:
      - 'null'
      - File
    doc: "Hessian matrix to dump"
    inputBinding:
      position: 101
      prefix: -mtx
  - id: output_mdp
    type:
      - 'null'
      - string
    doc: "grompp input file from run input file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -om
  - id: no_show_index_numbers
    type:
      - 'null'
      - boolean
    doc: "Disable: Show index numbers in output (leaving them out makes comparison easier, but creates a useless topology)"
    inputBinding:
      position: 101
      prefix: -nonr
  - id: show_parameters
    type:
      - 'null'
      - boolean
    doc: "Show parameters for each bonded interaction (for comparing dumps, it is useful to combine this with -nonr)"
    inputBinding:
      position: 101
      prefix: -param
  - id: list_whole_system
    type:
      - 'null'
      - boolean
    doc: "List the atoms and bonded interactions for the whole system instead of for each molecule type"
    inputBinding:
      position: 101
      prefix: -sys
  - id: show_original_parameters
    type:
      - 'null'
      - boolean
    doc: "Show input parameters from tpr as they were written by the version that produced the file, instead of how the current version reads them"
    inputBinding:
      position: 101
      prefix: -orgir
outputs:
  - id: output_mdp_out
    type:
      - 'null'
      - File
    doc: "grompp input file from run input file"
    outputBinding:
      glob: $(inputs.output_mdp)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mddb_gmx_dump.out
