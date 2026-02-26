cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iucn_sim
  - run_sim
label: iucn_sim_run_sim
doc: "Run future simulations based on IUCN data and status transition rates\n\nTool
  homepage: https://github.com/tobiashofmann88/iucn_extinction_simulator"
inputs:
  - id: burnin
    type:
      - 'null'
      - int
    doc: Burn-in for MCMC for extinction rate estimation (default=1000).
    default: 1000
    inputBinding:
      position: 101
      prefix: --burnin
  - id: conservation_increase_factor
    type:
      - 'null'
      - float
    doc: The transition rates leading to improvements in IUCN conservation 
      status are multiplied by this factor.
    inputBinding:
      position: 101
      prefix: --conservation_increase_factor
  - id: extinction_rates
    type:
      - 'null'
      - int
    doc: 'Estimation of extinction rates from simulation results: 0=off, 1=on (default=1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --extinction_rates
  - id: input_data
    type: File
    doc: Path to 'simulation_input_data.pkl' file created by esimate_rates 
      function.
    inputBinding:
      position: 101
      prefix: --input_data
  - id: model_unknown_as_lc
    type:
      - 'null'
      - int
    doc: Model new status for all DD and NE species as LC (best case scenario). 
      0=off, 1=on (default=0).
    default: 0
    inputBinding:
      position: 101
      prefix: --model_unknown_as_lc
  - id: n_gen
    type:
      - 'null'
      - int
    doc: Number of generations for MCMC for extinction rate estimation 
      (default=100000).
    default: 100000
    inputBinding:
      position: 101
      prefix: --n_gen
  - id: n_sim
    type:
      - 'null'
      - int
    doc: How many simulation replicates to run. At least 10,000 simulations are 
      recommended for accurate rate estimation (default). If the number of 
      simulation replicates exceeds the number of available transition rate 
      estimates (produced by the 'transition_rates' function), these rates will 
      be randomely resampled for the remaining simulations.
    default: '10000'
    inputBinding:
      position: 101
      prefix: --n_sim
  - id: n_years
    type:
      - 'null'
      - int
    doc: How many years to simulate into the future.
    inputBinding:
      position: 101
      prefix: --n_years
  - id: outdir
    type: Directory
    doc: Provide path to outdir where results will be saved.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: plot_diversity_trajectory
    type:
      - 'null'
      - int
    doc: 'Plots the simulated diversity trajectory: 0=off, 1=on (default=1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --plot_diversity_trajectory
  - id: plot_histograms
    type:
      - 'null'
      - int
    doc: 'Plots histograms of simulated extinction times for each species: 0=off,
      1=on (default=0).'
    default: 0
    inputBinding:
      position: 101
      prefix: --plot_histograms
  - id: plot_posterior
    type:
      - 'null'
      - int
    doc: 'Plots histograms of posterior rate estimates for each species: 0=off, 1=on
      (default=0).'
    default: 0
    inputBinding:
      position: 101
      prefix: --plot_posterior
  - id: plot_status_piechart
    type:
      - 'null'
      - int
    doc: 'Plots pie charts of status distribution: 0=off, 1=on (default=1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --plot_status_piechart
  - id: plot_status_trajectories
    type:
      - 'null'
      - int
    doc: 'Plots the simulated IUCN status trajectory: 0=off, 1=on (default=0).'
    default: 0
    inputBinding:
      position: 101
      prefix: --plot_status_trajectories
  - id: seed
    type:
      - 'null'
      - int
    doc: Set starting seed for future simulations.
    inputBinding:
      position: 101
      prefix: --seed
  - id: status_change
    type:
      - 'null'
      - int
    doc: Model IUCN status changes in future simulations. 0=off, 1=on 
      (default=1).
    default: 1
    inputBinding:
      position: 101
      prefix: --status_change
  - id: threat_increase_factor
    type:
      - 'null'
      - float
    doc: Opposite of conservation_increase_factor, multiplies the transition 
      rates leading to worsening in IUCN conservation status.
    inputBinding:
      position: 101
      prefix: --threat_increase_factor
  - id: until_n_taxa_extinct
    type:
      - 'null'
      - int
    doc: Setting this value will stop the simulations when n taxa have gone 
      extinct. This can be used to simulate the expected time until n 
      extinctions. The value of the --n_years flag in this case will be 
      interpreted as the maximum possible time frame, so set it large enough to 
      cover a realistic time-frame for these extinctions to occur. Set to 0 to 
      disable this function (default=0).
    default: 0
    inputBinding:
      position: 101
      prefix: --until_n_taxa_extinct
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iucn_sim:2.2.0--pyr40_0
stdout: iucn_sim_run_sim.out
