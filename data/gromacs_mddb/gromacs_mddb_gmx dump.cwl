cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmx dump
label: gromacs_mddb_gmx dump
doc: "Reads a run input file (.tpr), a trajectory (.trr/.xtc/tng), an energy file
  (.edr), a checkpoint file (.cpt) or topology file (.top) and prints that to standard
  output in a readable format. This program is essential for checking your run input
  file in case of problems.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: checkpoint_file
    type:
      - 'null'
      - File
    doc: Checkpoint file to dump
    inputBinding:
      position: 101
      prefix: -cp
  - id: energy_file
    type:
      - 'null'
      - File
    doc: Energy file to dump
    inputBinding:
      position: 101
      prefix: -e
  - id: hessian_matrix
    type:
      - 'null'
      - File
    doc: Hessian matrix to dump
    inputBinding:
      position: 101
      prefix: -mtx
  - id: list_whole_system
    type:
      - 'null'
      - boolean
    doc: List the atoms and bonded interactions for the whole system instead of 
      for each molecule type
    inputBinding:
      position: 101
      prefix: -nosys
  - id: run_input_file
    type:
      - 'null'
      - File
    doc: Run input file to dump
    inputBinding:
      position: 101
      prefix: -s
  - id: show_index_numbers
    type:
      - 'null'
      - boolean
    doc: Show index numbers in output (leaving them out makes comparison easier,
      but creates a useless topology)
    inputBinding:
      position: 101
      prefix: -nonr
  - id: show_original_parameters
    type:
      - 'null'
      - boolean
    doc: Show input parameters from tpr as they were written by the version that
      produced the file, instead of how the current version reads them
    inputBinding:
      position: 101
      prefix: -noorgir
  - id: show_parameters
    type:
      - 'null'
      - boolean
    doc: Show parameters for each bonded interaction (for comparing dumps, it is
      useful to combine this with -nonr)
    inputBinding:
      position: 101
      prefix: -noparam
  - id: topology_file
    type:
      - 'null'
      - File
    doc: Topology file to dump
    inputBinding:
      position: 101
      prefix: -p
  - id: trajectory_file
    type:
      - 'null'
      - File
    doc: 'Trajectory file to dump: xtc trr cpt gro g96 pdb tng'
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: grompp_input_file
    type:
      - 'null'
      - File
    doc: grompp input file from run input file
    outputBinding:
      glob: $(inputs.grompp_input_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
