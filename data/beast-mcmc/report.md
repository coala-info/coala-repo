# beast-mcmc CWL Generation Report

## beast-mcmc

### Tool Description
BEAST (Bayesian Evolutionary Analysis Sampling Trees)

### Metadata
- **Docker Image**: biocontainers/beast-mcmc:v1.10.4dfsg-1-deb_cv1
- **Homepage**: https://beast.community
- **Package**: https://anaconda.org/channels/bioconda/packages/beast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/beast-mcmc/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Unrecognized argument: --help

  Usage: beast [-verbose] [-warnings] [-strict] [-window] [-options] [-working] [-seed] [-prefix <PREFIX>] [-overwrite] [-errors <i>] [-threads <i>] [-java] [-tests] [-threshold <r>] [-adaptation_off] [-adaptation_target <r>] [-beagle] [-beagle_info] [-beagle_order <order>] [-beagle_instances <i>] [-beagle_multipartition <auto|on|off>] [-beagle_CPU] [-beagle_GPU] [-beagle_SSE] [-beagle_SSE_off] [-beagle_threading_off] [-beagle_thread_count <i>] [-beagle_cuda] [-beagle_opencl] [-beagle_single] [-beagle_double] [-beagle_async] [-beagle_scaling <default|dynamic|delayed|always|none>] [-beagle_delay_scaling_off] [-beagle_rescale] [-mpi] [-particles <FOLDER>] [-mc3_chains <i>] [-mc3_delta <r>] [-mc3_temperatures] [-mc3_swap <i>] [-load_state <FILENAME>] [-save_stem <FILENAME>] [-save_at] [-save_every] [-save_state <FILENAME>] [-force_resume] [-citations_file <FILENAME>] [-version] [-help] [<input-file-name>]
    -verbose Give verbose XML parsing messages
    -warnings Show warning messages about BEAST XML file
    -strict Fail on non-conforming BEAST XML file
    -window Provide a console window
    -options Display an options dialog
    -working Change working directory to input file's directory
    -seed Specify a random number generator seed
    -prefix Specify a prefix for all output log filenames
    -overwrite Allow overwriting of log files
    -errors Specify maximum number of numerical errors before stopping
    -threads The number of computational threads to use (default auto)
    -java Use Java only, no native implementations
    -tests The number of full evaluation tests to perform (default 1000)
    -threshold Full evaluation test threshold (default 0.1)
    -adaptation_off Don't adapt operator sizes
    -adaptation_target Target acceptance rate for adaptive operators (default 0.234)
    -beagle Use BEAGLE library if available (default on)
    -beagle_info BEAGLE: show information on available resources
    -beagle_order BEAGLE: set order of resource use
    -beagle_instances BEAGLE: divide site patterns amongst instances
    -beagle_multipartition BEAGLE: use multipartition extensions if available (default auto)
    -beagle_CPU BEAGLE: use CPU instance
    -beagle_GPU BEAGLE: use GPU instance if available
    -beagle_SSE BEAGLE: use SSE extensions if available
    -beagle_SSE_off BEAGLE: turn off use of SSE extensions
    -beagle_threading_off BEAGLE: turn off auto threading for a CPU instance
    -beagle_thread_count BEAGLE: manually set number of threads for a CPU instance
    -beagle_cuda BEAGLE: use CUDA parallization if available
    -beagle_opencl BEAGLE: use OpenCL parallization if available
    -beagle_single BEAGLE: use single precision if available
    -beagle_double BEAGLE: use double precision if available
    -beagle_async BEAGLE: use asynchronous kernels if available
    -beagle_scaling BEAGLE: specify scaling scheme to use
    -beagle_delay_scaling_off BEAGLE: don't wait until underflow for scaling option
    -beagle_rescale BEAGLE: frequency of rescaling (dynamic scaling only)
    -mpi Use MPI rank to label output
    -particles Specify a folder of particle start states
    -mc3_chains number of chains
    -mc3_delta temperature increment parameter
    -mc3_temperatures a comma-separated list of the hot chain temperatures
    -mc3_swap frequency at which chains temperatures will be swapped
    -load_state Specify a filename to load a saved state from
    -save_stem Specify a stem for the filenames to save states to
    -save_at Specify a state at which to save a state file
    -save_every Specify a frequency to save the state file
    -save_state Specify a filename to save state to
    -force_resume Force resuming from a saved state
    -citations_file Specify a filename to write a citation list to
    -version Print the version and credits and stop
    -help Print this information and stop

  Example: beast test.xml
  Example: beast -window test.xml
  Example: beast -help
```

