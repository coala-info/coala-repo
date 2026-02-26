cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmx
  - mdrun
label: gromacs_mddb_gmx mdrun
doc: "gmx mdrun is the main computational chemistry engine within GROMACS. Obviously,
  it performs Molecular Dynamics simulations, but it can also perform Stochastic Dynamics,
  Energy Minimization, test particle insertion or (re)calculation of energies. Normal
  mode analysis is another option. In this case mdrun builds a Hessian matrix from
  single conformation. For usual Normal Modes-like calculations, make sure that the
  structure provided is properly energy-minimized. The generated matrix can be diagonalized
  by gmx nmeig.\n\nTool homepage: https://www.gromacs.org/"
inputs:
  - id: append_output
    type:
      - 'null'
      - boolean
    doc: Append to previous output files when continuing from checkpoint instead
      of adding the simulation part number to all file names
    default: true
    inputBinding:
      position: 101
      prefix: -noappend
  - id: awh_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -awh
  - id: bonded_calculation_device
    type:
      - 'null'
      - string
    doc: 'Perform bonded calculations on: auto, cpu, gpu'
    default: auto
    inputBinding:
      position: 101
      prefix: -bonded
  - id: check_bonded_interactions_dd
    type:
      - 'null'
      - boolean
    doc: Check for all bonded interactions with DD
    default: true
    inputBinding:
      position: 101
      prefix: -nodddcheck
  - id: checkpoint_file
    type:
      - 'null'
      - File
    doc: Checkpoint file
    inputBinding:
      position: 101
      prefix: -cpi
  - id: checkpoint_interval
    type:
      - 'null'
      - string
    doc: Checkpoint interval (minutes)
    default: 15
    inputBinding:
      position: 101
      prefix: -cpt
  - id: checkpoint_output_file
    type:
      - 'null'
      - File
    doc: Checkpoint file
    inputBinding:
      position: 101
      prefix: -cpo
  - id: compressed_trajectory
    type:
      - 'null'
      - File
    doc: Compressed trajectory (tng format or portable xdr format)
    inputBinding:
      position: 101
      prefix: -x
  - id: dd_cell_size_increase_fraction
    type:
      - 'null'
      - string
    doc: Fraction in (0,1) by whose reciprocal the initial DD cell size will be 
      increased in order to provide a margin in which dynamic load balancing can
      act while preserving the minimum cell size.
    default: 0.8
    inputBinding:
      position: 101
      prefix: -dds
  - id: dd_rank_order
    type:
      - 'null'
      - string
    doc: 'DD rank order: interleave, pp_pme, cartesian'
    default: interleave
    inputBinding:
      position: 101
      prefix: -ddorder
  - id: default_filename
    type:
      - 'null'
      - string
    doc: Set the default filename for all file options
    inputBinding:
      position: 101
      prefix: -deffnm
  - id: dhdl_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -dhdl
  - id: domain_decomposition_grid
    type:
      - 'null'
      - string
    doc: Domain decomposition grid, 0 is optimize
    default: 0 0 0
    inputBinding:
      position: 101
      prefix: -dd
  - id: dynamic_load_balancing
    type:
      - 'null'
      - string
    doc: 'Dynamic load balancing (with DD): auto, no, yes'
    default: auto
    inputBinding:
      position: 101
      prefix: -dlb
  - id: ed_sampling_input
    type:
      - 'null'
      - File
    doc: ED sampling input
    inputBinding:
      position: 101
      prefix: -ei
  - id: edsam_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -eo
  - id: energy_file
    type:
      - 'null'
      - File
    doc: Energy file
    inputBinding:
      position: 101
      prefix: -e
  - id: field_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -field
  - id: full_precision_trajectory
    type:
      - 'null'
      - File
    doc: 'Full precision trajectory: trr cpt tng'
    inputBinding:
      position: 101
      prefix: -o
  - id: gpu_id
    type:
      - 'null'
      - string
    doc: List of unique GPU device IDs available to use
    inputBinding:
      position: 101
      prefix: -gpu_id
  - id: gpu_tasks
    type:
      - 'null'
      - string
    doc: List of GPU device IDs, mapping each PP task on each node to a device
    inputBinding:
      position: 101
      prefix: -gputasks
  - id: hessian_matrix_file
    type:
      - 'null'
      - File
    doc: Hessian matrix
    inputBinding:
      position: 101
      prefix: -mtx
  - id: imd_forces_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -if
  - id: keep_numbered_checkpoints
    type:
      - 'null'
      - boolean
    doc: Keep and number checkpoint files
    default: false
    inputBinding:
      position: 101
      prefix: -nocpnum
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: -g
  - id: max_distance_bonded_dd
    type:
      - 'null'
      - string
    doc: The maximum distance for bonded interactions with DD (nm), 0 is 
      determine from initial coordinates
    default: 0
    inputBinding:
      position: 101
      prefix: -rdd
  - id: max_distance_p_lincs
    type:
      - 'null'
      - string
    doc: Maximum distance for P-LINCS (nm), 0 is estimate
    default: 0
    inputBinding:
      position: 101
      prefix: -rcon
  - id: max_hours
    type:
      - 'null'
      - string
    doc: Terminate after 0.99 times this time (hours)
    default: -1
    inputBinding:
      position: 101
      prefix: -maxh
  - id: membed_data_file
    type:
      - 'null'
      - File
    doc: Generic data file
    inputBinding:
      position: 101
      prefix: -membed
  - id: membed_index_file
    type:
      - 'null'
      - File
    doc: Index file
    inputBinding:
      position: 101
      prefix: -mn
  - id: membed_topology_file
    type:
      - 'null'
      - File
    doc: Topology file
    inputBinding:
      position: 101
      prefix: -mp
  - id: non_bonded_calculation_device
    type:
      - 'null'
      - string
    doc: 'Calculate non-bonded interactions on: auto, cpu, gpu'
    default: auto
    inputBinding:
      position: 101
      prefix: -nb
  - id: nstlist_verlet_buffer
    type:
      - 'null'
      - int
    doc: Set nstlist when using a Verlet buffer tolerance (0 is guess)
    default: 0
    inputBinding:
      position: 101
      prefix: -nstlist
  - id: num_pme_ranks
    type:
      - 'null'
      - int
    doc: Number of separate ranks to be used for PME, -1 is guess
    default: -1
    inputBinding:
      position: 101
      prefix: -npme
  - id: num_random_exchanges
    type:
      - 'null'
      - int
    doc: Number of random exchanges to carry out each exchange interval (N^3 is 
      one suggestion). -nex zero or not specified gives neighbor replica 
      exchange.
    default: 0
    inputBinding:
      position: 101
      prefix: -nex
  - id: num_steps
    type:
      - 'null'
      - int
    doc: Run this number of steps (-1 means infinite, -2 means use mdp option, 
      smaller is invalid)
    default: -2
    inputBinding:
      position: 101
      prefix: -nsteps
  - id: omp_threads_per_mpi_rank
    type:
      - 'null'
      - int
    doc: Number of OpenMP threads per MPI rank to start (0 is guess)
    default: 0
    inputBinding:
      position: 101
      prefix: -ntomp
  - id: omp_threads_per_mpi_rank_pme
    type:
      - 'null'
      - int
    doc: Number of OpenMP threads per MPI rank to start (0 is -ntomp)
    default: 0
    inputBinding:
      position: 101
      prefix: -ntomp_pme
  - id: pin_offset
    type:
      - 'null'
      - int
    doc: The lowest logical core number to which mdrun should pin the first 
      thread
    default: 0
    inputBinding:
      position: 101
      prefix: -pinoffset
  - id: pin_stride
    type:
      - 'null'
      - int
    doc: Pinning distance in logical cores for threads, use 0 to minimize the 
      number of threads per physical core
    default: 0
    inputBinding:
      position: 101
      prefix: -pinstride
  - id: pinning
    type:
      - 'null'
      - string
    doc: 'Whether mdrun should try to set thread affinities: auto, on, off'
    default: auto
    inputBinding:
      position: 101
      prefix: -pin
  - id: pme_calculation_device
    type:
      - 'null'
      - string
    doc: 'Perform PME calculations on: auto, cpu, gpu'
    default: auto
    inputBinding:
      position: 101
      prefix: -pme
  - id: pme_fft_calculation_device
    type:
      - 'null'
      - string
    doc: 'Perform PME FFT calculations on: auto, cpu, gpu'
    default: auto
    inputBinding:
      position: 101
      prefix: -pmefft
  - id: print_force_threshold
    type:
      - 'null'
      - string
    doc: Print all forces larger than this (kJ/mol nm)
    default: -1
    inputBinding:
      position: 101
      prefix: -pforce
  - id: pullf_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -pf
  - id: pullx_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -px
  - id: replica_exchange_period
    type:
      - 'null'
      - int
    doc: Attempt replica exchange periodically with this period (steps)
    default: 0
    inputBinding:
      position: 101
      prefix: -replex
  - id: reproducibility
    type:
      - 'null'
      - boolean
    doc: Try to avoid optimizations that affect binary reproducibility
    default: false
    inputBinding:
      position: 101
      prefix: -noreprod
  - id: rerun_trajectory
    type:
      - 'null'
      - File
    doc: 'Trajectory: xtc trr cpt gro g96 pdb tng'
    inputBinding:
      position: 101
      prefix: -rerun
  - id: reseed_replica_exchange
    type:
      - 'null'
      - int
    doc: Seed for replica exchange, -1 is generate a seed
    default: -1
    inputBinding:
      position: 101
      prefix: -reseed
  - id: rotangles_log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: -ra
  - id: rotation_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -ro
  - id: rotslabs_log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: -rs
  - id: rottorque_log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: -rt
  - id: run_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Run directory
    inputBinding:
      position: 101
      prefix: -multidir
  - id: run_input_file
    type:
      - 'null'
      - File
    doc: Portable xdr run input file
    inputBinding:
      position: 101
      prefix: -s
  - id: structure_file
    type:
      - 'null'
      - File
    doc: 'Structure file: gro g96 pdb brk ent esp'
    inputBinding:
      position: 101
      prefix: -c
  - id: swapions_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -swap
  - id: table_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -table
  - id: tableb_files
    type:
      - 'null'
      - type: array
        items: File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -tableb
  - id: tablep_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -tablep
  - id: thread_mpi_ranks
    type:
      - 'null'
      - int
    doc: Number of thread-MPI ranks to start (0 is guess)
    default: 0
    inputBinding:
      position: 101
      prefix: -ntmpi
  - id: total_threads
    type:
      - 'null'
      - int
    doc: Total number of threads to start (0 is guess)
    default: 0
    inputBinding:
      position: 101
      prefix: -nt
  - id: tpi_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -tpi
  - id: tpidist_file
    type:
      - 'null'
      - File
    doc: xvgr/xmgr file
    inputBinding:
      position: 101
      prefix: -tpid
  - id: tune_pme
    type:
      - 'null'
      - boolean
    doc: Optimize PME load between PP/PME ranks or GPU/CPU
    default: true
    inputBinding:
      position: 101
      prefix: -notunepme
  - id: update_constraints_device
    type:
      - 'null'
      - string
    doc: 'Perform update and constraints on: auto, cpu, gpu'
    default: auto
    inputBinding:
      position: 101
      prefix: -update
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be loud and noisy
    default: false
    inputBinding:
      position: 101
      prefix: -nov
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacs:2022
stdout: gromacs_mddb_gmx mdrun.out
