cwlVersion: v1.2
class: CommandLineTool
baseCommand: beast
label: beast
doc: "BEAST (Bayesian Evolutionary Analysis Sampling Toolkit)\n\nTool homepage: https://beast.community"
inputs:
  - id: input_file_name
    type:
      - 'null'
      - File
    doc: Input file name
    inputBinding:
      position: 1
  - id: adaptation_off
    type:
      - 'null'
      - boolean
    doc: Don't adapt operator sizes
    inputBinding:
      position: 102
      prefix: -adaptation_off
  - id: adaptation_target
    type:
      - 'null'
      - float
    doc: Target acceptance rate for adaptive operators (default 0.234)
    default: 0.234
    inputBinding:
      position: 102
      prefix: -adaptation_target
  - id: ambiguous_threshold
    type:
      - 'null'
      - float
    doc: Maximum proportion of ambiguous characters to allow compression 
      (default 0.25)
    default: 0.25
    inputBinding:
      position: 102
      prefix: -ambiguous_threshold
  - id: beagle
    type:
      - 'null'
      - boolean
    doc: Use BEAGLE library if available (default on)
    default: on
    inputBinding:
      position: 102
      prefix: -beagle
  - id: beagle_CPU
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use CPU instance'
    inputBinding:
      position: 102
      prefix: -beagle_CPU
  - id: beagle_GPU
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use GPU instance if available'
    inputBinding:
      position: 102
      prefix: -beagle_GPU
  - id: beagle_SSE
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use SSE extensions if available'
    inputBinding:
      position: 102
      prefix: -beagle_SSE
  - id: beagle_SSE_off
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: turn off use of SSE extensions'
    inputBinding:
      position: 102
      prefix: -beagle_SSE_off
  - id: beagle_async
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use asynchronous kernels if available'
    inputBinding:
      position: 102
      prefix: -beagle_async
  - id: beagle_auto
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: automatically select fastest resource for analysis'
    inputBinding:
      position: 102
      prefix: -beagle_auto
  - id: beagle_cuda
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use CUDA parallization if available'
    inputBinding:
      position: 102
      prefix: -beagle_cuda
  - id: beagle_delay_scaling_off
    type:
      - 'null'
      - boolean
    doc: "BEAGLE: don't wait until underflow for scaling option"
    inputBinding:
      position: 102
      prefix: -beagle_delay_scaling_off
  - id: beagle_double
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use double precision if available'
    inputBinding:
      position: 102
      prefix: -beagle_double
  - id: beagle_extra_buffer_count
    type:
      - 'null'
      - int
    doc: 'BEAGLE: reserve extra transition matrix buffers for convolutions'
    inputBinding:
      position: 102
      prefix: -beagle_extra_buffer_count
  - id: beagle_info
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: show information on available resources'
    inputBinding:
      position: 102
      prefix: -beagle_info
  - id: beagle_instances
    type:
      - 'null'
      - int
    doc: 'BEAGLE: divide site patterns amongst instances'
    inputBinding:
      position: 102
      prefix: -beagle_instances
  - id: beagle_low_memory
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use lower memory pre-order traversal kernels'
    inputBinding:
      position: 102
      prefix: -beagle_low_memory
  - id: beagle_multipartition
    type:
      - 'null'
      - string
    doc: 'BEAGLE: use multipartition extensions if available (default auto)'
    default: auto
    inputBinding:
      position: 102
      prefix: -beagle_multipartition
  - id: beagle_opencl
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use OpenCL parallization if available'
    inputBinding:
      position: 102
      prefix: -beagle_opencl
  - id: beagle_order
    type:
      - 'null'
      - string
    doc: 'BEAGLE: set order of resource use'
    inputBinding:
      position: 102
      prefix: -beagle_order
  - id: beagle_rescale
    type:
      - 'null'
      - string
    doc: 'BEAGLE: frequency of rescaling (dynamic scaling only)'
    inputBinding:
      position: 102
      prefix: -beagle_rescale
  - id: beagle_scaling
    type:
      - 'null'
      - string
    doc: 'BEAGLE: specify scaling scheme to use'
    inputBinding:
      position: 102
      prefix: -beagle_scaling
  - id: beagle_single
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: use single precision if available'
    inputBinding:
      position: 102
      prefix: -beagle_single
  - id: beagle_threading_off
    type:
      - 'null'
      - boolean
    doc: 'BEAGLE: turn off multi-threading for a CPU instance'
    inputBinding:
      position: 102
      prefix: -beagle_threading_off
  - id: beagle_threads
    type:
      - 'null'
      - int
    doc: 'BEAGLE: manually set number of threads per CPU instance (default auto)'
    default: auto
    inputBinding:
      position: 102
      prefix: -beagle_threads
  - id: citations_file
    type:
      - 'null'
      - File
    doc: Specify a filename to write a citation list to
    inputBinding:
      position: 102
      prefix: -citations_file
  - id: citations_off
    type:
      - 'null'
      - boolean
    doc: Turn off writing citations to file
    inputBinding:
      position: 102
      prefix: -citations_off
  - id: errors
    type:
      - 'null'
      - int
    doc: Specify maximum number of numerical errors before stopping
    inputBinding:
      position: 102
      prefix: -errors
  - id: fail_threads
    type:
      - 'null'
      - boolean
    doc: Exit with error on uncaught exception in thread
    inputBinding:
      position: 102
      prefix: -fail_threads
  - id: force_resume
    type:
      - 'null'
      - boolean
    doc: Force resuming from a saved state
    inputBinding:
      position: 102
      prefix: -force_resume
  - id: full_checkpoint_precision
    type:
      - 'null'
      - boolean
    doc: Use hex-encoded doubles in checkpoint files
    inputBinding:
      position: 102
      prefix: -full_checkpoint_precision
  - id: ignore_versions
    type:
      - 'null'
      - boolean
    doc: Ignore mismatches between XML and BEAST versions
    inputBinding:
      position: 102
      prefix: -ignore_versions
  - id: java
    type:
      - 'null'
      - boolean
    doc: Use Java only, no native implementations
    inputBinding:
      position: 102
      prefix: -java
  - id: load_state
    type:
      - 'null'
      - File
    doc: Specify a filename to load a saved state from
    inputBinding:
      position: 102
      prefix: -load_state
  - id: mc3_chains
    type:
      - 'null'
      - int
    doc: number of chains
    inputBinding:
      position: 102
      prefix: -mc3_chains
  - id: mc3_delta
    type:
      - 'null'
      - float
    doc: temperature increment parameter
    inputBinding:
      position: 102
      prefix: -mc3_delta
  - id: mc3_scheme
    type:
      - 'null'
      - string
    doc: Specify parallel tempering swap scheme
    inputBinding:
      position: 102
      prefix: -mc3_scheme
  - id: mc3_swap
    type:
      - 'null'
      - int
    doc: frequency at which chains temperatures will be swapped
    inputBinding:
      position: 102
      prefix: -mc3_swap
  - id: mc3_temperatures
    type:
      - 'null'
      - string
    doc: a comma-separated list of the hot chain temperatures
    inputBinding:
      position: 102
      prefix: -mc3_temperatures
  - id: mpi
    type:
      - 'null'
      - boolean
    doc: Use MPI rank to label output
    inputBinding:
      position: 102
      prefix: -mpi
  - id: options
    type:
      - 'null'
      - boolean
    doc: Display an options dialog
    inputBinding:
      position: 102
      prefix: -options
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Allow overwriting of log files
    inputBinding:
      position: 102
      prefix: -overwrite
  - id: particles
    type:
      - 'null'
      - Directory
    doc: Specify a folder of particle start states
    inputBinding:
      position: 102
      prefix: -particles
  - id: pattern_compression
    type:
      - 'null'
      - string
    doc: Site pattern compression mode - unique | ambiguous_constant | 
      ambiguous_all (default unique)
    default: unique
    inputBinding:
      position: 102
      prefix: -pattern_compression
  - id: plugins_dir
    type:
      - 'null'
      - File
    doc: Specify a directory to load plugins from, multiple can be separated 
      with ':'
    inputBinding:
      position: 102
      prefix: -plugins_dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix for all output log filenames
    inputBinding:
      position: 102
      prefix: -prefix
  - id: save_at
    type:
      - 'null'
      - string
    doc: Specify a state at which to save a state file
    inputBinding:
      position: 102
      prefix: -save_at
  - id: save_every
    type:
      - 'null'
      - string
    doc: Specify a frequency to save the state file
    inputBinding:
      position: 102
      prefix: -save_every
  - id: save_state
    type:
      - 'null'
      - File
    doc: Specify a filename to save state to
    inputBinding:
      position: 102
      prefix: -save_state
  - id: save_stem
    type:
      - 'null'
      - File
    doc: Specify a stem for the filenames to save states to
    inputBinding:
      position: 102
      prefix: -save_stem
  - id: save_time
    type:
      - 'null'
      - string
    doc: Specify a length of time after which to save a state file
    inputBinding:
      position: 102
      prefix: -save_time
  - id: seed
    type:
      - 'null'
      - int
    doc: Specify a random number generator seed
    inputBinding:
      position: 102
      prefix: -seed
  - id: show_operators
    type:
      - 'null'
      - boolean
    doc: Print transition kernel performance to file
    inputBinding:
      position: 102
      prefix: -show_operators
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Fail on non-conforming BEAST XML file
    inputBinding:
      position: 102
      prefix: -strict
  - id: tests
    type:
      - 'null'
      - int
    doc: The number of full evaluation tests to perform (default 1000)
    default: 1000
    inputBinding:
      position: 102
      prefix: -tests
  - id: threads
    type:
      - 'null'
      - int
    doc: The maximum number of computational threads to use (default auto)
    default: auto
    inputBinding:
      position: 102
      prefix: -threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: Full evaluation test threshold (default 0.1)
    default: 0.1
    inputBinding:
      position: 102
      prefix: -threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Give verbose XML parsing messages
    inputBinding:
      position: 102
      prefix: -verbose
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: Show warning messages about BEAST XML file
    inputBinding:
      position: 102
      prefix: -warnings
  - id: window
    type:
      - 'null'
      - boolean
    doc: Provide a console window
    inputBinding:
      position: 102
      prefix: -window
  - id: working
    type:
      - 'null'
      - boolean
    doc: Change working directory to input file's directory
    inputBinding:
      position: 102
      prefix: -working
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beast:10.5.0--hdfd78af_0
stdout: beast.out
