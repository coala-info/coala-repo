cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flexsweep
  - fvs-discoal
label: flexsweep_fvs-discoal
doc: "Estimate summary statistics from discoal simulations and build feature vectors.\n\
  \n  This command processes both neutral and sweep simulations in the given\n  directory,
  computes a panel of summary statistics, and generates two\n  outputs: a Parquet
  dataframe containing feature vectors, a Pickle dictionary\n  containing neutral
  expectations and standard deviations (used for\n  normalization during CNN training).\n\
  \nTool homepage: https://github.com/jmurga/flexsweep"
inputs:
  - id: nthreads
    type: int
    doc: Number of threads for parallelization
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: simulations_path
    type: Directory
    doc: Directory containing neutral and sweeps discoal simulations.
    inputBinding:
      position: 101
      prefix: --simulations_path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
stdout: flexsweep_fvs-discoal.out
