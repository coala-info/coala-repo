cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - mdrun
label: gromacs_mddb_gmx_mdrun
doc: "gmx mdrun is the main computational chemistry engine within GROMACS. Obviously, it performs Molecular Dynamics simulations, but it can also perform Stochastic Dynamics, Energy Minimization, test particle insertion or (re)calculation of energies. Normal mode analysis is another option. In this case mdrun builds a Hessian matrix from single conformation. For usual Normal Modes-like calculations, make sure that the structure provided is properly energy-minimized. The generated matrix can be diagonalized by gmx nmeig.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: run_input
    type: File
    doc: "Portable xdr run input file"
    inputBinding:
      position: 101
      prefix: -s
  - id: checkpoint_input
    type:
      - 'null'
      - File
    doc: "Checkpoint file"
    inputBinding:
      position: 101
      prefix: -cpi
  - id: table_file
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    inputBinding:
      position: 101
      prefix: -table
  - id: tablep_file
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file xvgr/xmgr file"
    inputBinding:
      position: 101
      prefix: -tablep
  - id: rerun_file
    type:
      - 'null'
      - File
    doc: "Trajectory: xtc trr cpt gro g96 pdb tng"
    inputBinding:
      position: 101
      prefix: -rerun
  - id: ei_file
    type:
      - 'null'
      - File
    doc: "ED sampling input Run directory"
    inputBinding:
      position: 101
      prefix: -ei
  - id: awh_file
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    inputBinding:
      position: 101
      prefix: -awh
  - id: membed_file
    type:
      - 'null'
      - File
    doc: "Generic data file"
    inputBinding:
      position: 101
      prefix: -membed
  - id: mp_file
    type:
      - 'null'
      - File
    doc: "Topology file"
    inputBinding:
      position: 101
      prefix: -mp
  - id: mn_file
    type:
      - 'null'
      - File
    doc: "Index file"
    inputBinding:
      position: 101
      prefix: -mn
  - id: output_trajectory
    type:
      - 'null'
      - string
    doc: "Full precision trajectory: trr cpt tng (output file name)"
    default: traj.trr
    inputBinding:
      position: 101
      prefix: -o
  - id: output_xtc
    type:
      - 'null'
      - string
    doc: "Compressed trajectory (tng format or portable xdr format) (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -x
  - id: checkpoint_output
    type:
      - 'null'
      - string
    doc: "Checkpoint file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -cpo
  - id: output_structure
    type:
      - 'null'
      - string
    doc: "Structure file: gro g96 pdb brk ent esp (output file name)"
    default: confout.gro
    inputBinding:
      position: 101
      prefix: -c
  - id: output_energy
    type:
      - 'null'
      - string
    doc: "Energy file (output file name)"
    default: ener.edr
    inputBinding:
      position: 101
      prefix: -e
  - id: output_log
    type:
      - 'null'
      - string
    doc: "Log file (output file name)"
    default: md.log
    inputBinding:
      position: 101
      prefix: -g
  - id: dhdl_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -dhdl
  - id: field_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -field
  - id: tpi_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -tpi
  - id: tpid_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -tpid
  - id: eo_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -eo
  - id: px_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -px
  - id: pf_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -pf
  - id: ro_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -ro
  - id: ra_file
    type:
      - 'null'
      - string
    doc: "Log file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -ra
  - id: rs_file
    type:
      - 'null'
      - string
    doc: "Log file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -rs
  - id: rt_file
    type:
      - 'null'
      - string
    doc: "Log file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -rt
  - id: mtx_file
    type:
      - 'null'
      - string
    doc: "Hessian matrix (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -mtx
  - id: if_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -if
  - id: swap_file
    type:
      - 'null'
      - string
    doc: "xvgr/xmgr file (output file name; optional)"
    inputBinding:
      position: 101
      prefix: -swap
  - id: xvg
    type:
      - 'null'
      - string
    doc: "xvg plot formatting: xmgrace, xmgr, none"
    inputBinding:
      position: 101
      prefix: -xvg
  - id: dd
    type:
      - 'null'
      - type: array
        items: float
    doc: "Domain decomposition grid, 0 is optimize"
    inputBinding:
      position: 101
      prefix: -dd
  - id: ddorder
    type:
      - 'null'
      - string
    doc: "DD rank order: interleave, pp_pme, cartesian"
    inputBinding:
      position: 101
      prefix: -ddorder
  - id: npme
    type:
      - 'null'
      - int
    doc: "Number of separate ranks to be used for PME, -1 is guess"
    inputBinding:
      position: 101
      prefix: -npme
  - id: nt
    type:
      - 'null'
      - int
    doc: "Total number of threads to start (0 is guess)"
    inputBinding:
      position: 101
      prefix: -nt
  - id: ntmpi
    type:
      - 'null'
      - int
    doc: "Number of thread-MPI ranks to start (0 is guess)"
    inputBinding:
      position: 101
      prefix: -ntmpi
  - id: ntomp
    type:
      - 'null'
      - int
    doc: "Number of OpenMP threads per MPI rank to start (0 is guess)"
    inputBinding:
      position: 101
      prefix: -ntomp
  - id: ntomp_pme
    type:
      - 'null'
      - int
    doc: "Number of OpenMP threads per MPI rank to start (0 is -ntomp)"
    inputBinding:
      position: 101
      prefix: -ntomp_pme
  - id: pin
    type:
      - 'null'
      - string
    doc: "Whether mdrun should try to set thread affinities: auto, on, off"
    inputBinding:
      position: 101
      prefix: -pin
  - id: pinoffset
    type:
      - 'null'
      - int
    doc: "The lowest logical core number to which mdrun should pin the first thread"
    inputBinding:
      position: 101
      prefix: -pinoffset
  - id: pinstride
    type:
      - 'null'
      - int
    doc: "Pinning distance in logical cores for threads, use 0 to minimize the number of threads per physical core List of unique GPU device IDs available to use List of GPU device IDs, mapping each PP task on each node to a device"
    inputBinding:
      position: 101
      prefix: -pinstride
  - id: no_ddcheck
    type:
      - 'null'
      - boolean
    doc: "Disable: Check for all bonded interactions with DD"
    inputBinding:
      position: 101
      prefix: -noddcheck
  - id: rdd
    type:
      - 'null'
      - float
    doc: "The maximum distance for bonded interactions with DD (nm), 0 is determine from initial coordinates"
    inputBinding:
      position: 101
      prefix: -rdd
  - id: rcon
    type:
      - 'null'
      - float
    doc: "Maximum distance for P-LINCS (nm), 0 is estimate"
    inputBinding:
      position: 101
      prefix: -rcon
  - id: dlb
    type:
      - 'null'
      - string
    doc: "Dynamic load balancing (with DD): auto, no, yes"
    inputBinding:
      position: 101
      prefix: -dlb
  - id: dds
    type:
      - 'null'
      - float
    doc: "Fraction in (0,1) by whose reciprocal the initial DD cell size will be increased in order to provide a margin in which dynamic load balancing can act while preserving the minimum cell size."
    inputBinding:
      position: 101
      prefix: -dds
  - id: nb
    type:
      - 'null'
      - string
    doc: "Calculate non-bonded interactions on: auto, cpu, gpu"
    inputBinding:
      position: 101
      prefix: -nb
  - id: nstlist
    type:
      - 'null'
      - int
    doc: "Set nstlist when using a Verlet buffer tolerance (0 is guess)"
    inputBinding:
      position: 101
      prefix: -nstlist
  - id: no_tunepme
    type:
      - 'null'
      - boolean
    doc: "Disable: Optimize PME load between PP/PME ranks or GPU/CPU"
    inputBinding:
      position: 101
      prefix: -notunepme
  - id: pme
    type:
      - 'null'
      - string
    doc: "Perform PME calculations on: auto, cpu, gpu"
    inputBinding:
      position: 101
      prefix: -pme
  - id: pmefft
    type:
      - 'null'
      - string
    doc: "Perform PME FFT calculations on: auto, cpu, gpu"
    inputBinding:
      position: 101
      prefix: -pmefft
  - id: bonded
    type:
      - 'null'
      - string
    doc: "Perform bonded calculations on: auto, cpu, gpu"
    inputBinding:
      position: 101
      prefix: -bonded
  - id: update
    type:
      - 'null'
      - string
    doc: "Perform update and constraints on: auto, cpu, gpu"
    inputBinding:
      position: 101
      prefix: -update
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Be loud and noisy"
    inputBinding:
      position: 101
      prefix: -v
  - id: pforce
    type:
      - 'null'
      - float
    doc: "Print all forces larger than this (kJ/mol nm)"
    inputBinding:
      position: 101
      prefix: -pforce
  - id: reprod
    type:
      - 'null'
      - boolean
    doc: "Try to avoid optimizations that affect binary reproducibility"
    inputBinding:
      position: 101
      prefix: -reprod
  - id: cpt
    type:
      - 'null'
      - float
    doc: "Checkpoint interval (minutes)"
    inputBinding:
      position: 101
      prefix: -cpt
  - id: cpnum
    type:
      - 'null'
      - boolean
    doc: "Keep and number checkpoint files"
    inputBinding:
      position: 101
      prefix: -cpnum
  - id: no_append
    type:
      - 'null'
      - boolean
    doc: "Disable: Append to previous output files when continuing from checkpoint instead of adding the simulation part number to all file names"
    inputBinding:
      position: 101
      prefix: -noappend
  - id: nsteps
    type:
      - 'null'
      - int
    doc: "Run this number of steps (-1 means infinite, -2 means use mdp option, smaller is invalid)"
    inputBinding:
      position: 101
      prefix: -nsteps
  - id: maxh
    type:
      - 'null'
      - float
    doc: "Terminate after 0.99 times this time (hours)"
    inputBinding:
      position: 101
      prefix: -maxh
  - id: replex
    type:
      - 'null'
      - int
    doc: "Attempt replica exchange periodically with this period (steps)"
    inputBinding:
      position: 101
      prefix: -replex
  - id: nex
    type:
      - 'null'
      - int
    doc: "Number of random exchanges to carry out each exchange interval (N^3 is one suggestion).  -nex zero or not specified gives neighbor replica exchange."
    inputBinding:
      position: 101
      prefix: -nex
  - id: reseed
    type:
      - 'null'
      - int
    doc: "Seed for replica exchange, -1 is generate a seed"
    inputBinding:
      position: 101
      prefix: -reseed
outputs:
  - id: output_trajectory_out
    type:
      - 'null'
      - File
    doc: "Full precision trajectory: trr cpt tng"
    outputBinding:
      glob: $(inputs.output_trajectory)
  - id: output_xtc_out
    type:
      - 'null'
      - File
    doc: "Compressed trajectory (tng format or portable xdr format)"
    outputBinding:
      glob: $(inputs.output_xtc)
  - id: checkpoint_output_out
    type:
      - 'null'
      - File
    doc: "Checkpoint file"
    outputBinding:
      glob: $(inputs.checkpoint_output)
  - id: output_structure_out
    type:
      - 'null'
      - File
    doc: "Structure file: gro g96 pdb brk ent esp"
    outputBinding:
      glob: $(inputs.output_structure)
  - id: output_energy_out
    type:
      - 'null'
      - File
    doc: "Energy file"
    outputBinding:
      glob: $(inputs.output_energy)
  - id: output_log_out
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: $(inputs.output_log)
  - id: dhdl_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.dhdl_file)
  - id: field_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.field_file)
  - id: tpi_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.tpi_file)
  - id: tpid_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.tpid_file)
  - id: eo_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.eo_file)
  - id: px_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.px_file)
  - id: pf_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.pf_file)
  - id: ro_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.ro_file)
  - id: ra_file_out
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: $(inputs.ra_file)
  - id: rs_file_out
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: $(inputs.rs_file)
  - id: rt_file_out
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: $(inputs.rt_file)
  - id: mtx_file_out
    type:
      - 'null'
      - File
    doc: "Hessian matrix"
    outputBinding:
      glob: $(inputs.mtx_file)
  - id: if_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.if_file)
  - id: swap_file_out
    type:
      - 'null'
      - File
    doc: "xvgr/xmgr file"
    outputBinding:
      glob: $(inputs.swap_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mddb_gmx_mdrun.out
