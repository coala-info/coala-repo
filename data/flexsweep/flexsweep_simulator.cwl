cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexsweep simulator
label: flexsweep_simulator
doc: "Run the discoal Simulator with user-specified parameters.\n\nTool homepage:
  https://github.com/jmurga/flexsweep"
inputs:
  - id: demes
    type: string
    doc: Path to the demes YAML file describing demography.
    inputBinding:
      position: 101
      prefix: --demes
  - id: discoal_path
    type:
      - 'null'
      - File
    doc: Path to the discoal executable. If not provided, using pre-compiled 
      flexsweep.DISCOAL.
    inputBinding:
      position: 101
      prefix: --discoal_path
  - id: locus_length
    type:
      - 'null'
      - int
    doc: Length of the simulated locus in base pairs.
    inputBinding:
      position: 101
      prefix: --locus_length
  - id: mutation_rate
    type:
      - 'null'
      - string
    doc: "Mutation rate specification. Please input: - Two comma-separated values:
      lower,upper (uniform distribution bounds):  - Three values: min, max and mean
      of an exponential distribution.Example: '5e-9,2e-8' or '5e-9,2e-8,1e-8'"
    inputBinding:
      position: 101
      prefix: --mutation_rate
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads for parallelization.
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: num_simulations
    type:
      - 'null'
      - int
    doc: Number of neutral and sweep simulations to generate.
    inputBinding:
      position: 101
      prefix: --num_simulations
  - id: output_folder
    type: Directory
    doc: Directory where simulation outputs will be saved.
    inputBinding:
      position: 101
      prefix: --output_folder
  - id: recombination_rate
    type:
      - 'null'
      - string
    doc: "Recombination rate specification. Please input: - Two comma-separated values:
      lower,upper (uniform distribution bounds):  - Three values: min, max and mean
      of an exponential distribution.Example: '1e-9,4e-8' or '1e-9,4e-8,1e-8'"
    inputBinding:
      position: 101
      prefix: --recombination_rate
  - id: sample_size
    type: int
    doc: Number of haplotypes
    inputBinding:
      position: 101
      prefix: --sample_size
  - id: time
    type:
      - 'null'
      - string
    doc: 'Adaptive mutation time range in generations. Two comma-separated values:
      start,end.'
    inputBinding:
      position: 101
      prefix: --time
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexsweep:1.3--pyhdfd78af_0
stdout: flexsweep_simulator.out
