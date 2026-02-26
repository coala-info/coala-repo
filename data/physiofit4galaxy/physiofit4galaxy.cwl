cwlVersion: v1.2
class: CommandLineTool
baseCommand: Physiofit
label: physiofit4galaxy
doc: "Extracellular flux estimation software\n\nTool homepage: https://github.com/MetaSys-LISBP/PhysioFit4Galaxy"
inputs:
  - id: conc_biom_bounds
    type:
      - 'null'
      - string
    doc: Bounds on initial biomass concentrations.Give bounds as a tuple.
    inputBinding:
      position: 101
      prefix: --conc_biom_bounds
  - id: conc_met_bounds
    type:
      - 'null'
      - string
    doc: Bounds on initial metabolite concentrations. Give bounds as a tuple.
    inputBinding:
      position: 101
      prefix: --conc_met_bounds
  - id: config
    type:
      - 'null'
      - File
    doc: Path to config file in json format
    inputBinding:
      position: 101
      prefix: --config
  - id: data
    type:
      - 'null'
      - File
    doc: Path to data file in tabulated format (txt or tsv)
    inputBinding:
      position: 101
      prefix: --data
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: Activate the debug logs
    inputBinding:
      position: 101
      prefix: --debug_mode
  - id: deg
    type:
      - 'null'
      - boolean
    doc: Should degradation constants be taken into consideration. Add for True.
      Constants should then be given in dictionary format
    inputBinding:
      position: 101
      prefix: --deg
  - id: flux_biom_bounds
    type:
      - 'null'
      - string
    doc: Bounds on initial biomass fluxes. Give bounds as a tuple.
    inputBinding:
      position: 101
      prefix: --flux_biom_bounds
  - id: flux_met_bounds
    type:
      - 'null'
      - string
    doc: Bounds on initial metabolite fluxes. Give bounds as a tuple.
    inputBinding:
      position: 101
      prefix: --flux_met_bounds
  - id: galaxy
    type:
      - 'null'
      - boolean
    doc: Is the CLI being used on the galaxy platform
    inputBinding:
      position: 101
      prefix: --galaxy
  - id: lag
    type:
      - 'null'
      - boolean
    doc: Should lag phase be estimated. Add for True
    inputBinding:
      position: 101
      prefix: --lag
  - id: montecarlo
    type:
      - 'null'
      - int
    doc: Should sensitivity analysis be performed. Number of iterations should 
      be given as an integer
    inputBinding:
      position: 101
      prefix: --montecarlo
  - id: sd
    type:
      - 'null'
      - string
    doc: Standard deviation on measurements. Give sds in dictionary format
    inputBinding:
      position: 101
      prefix: --sd
  - id: vini
    type:
      - 'null'
      - string
    doc: Select an initial value for fluxes to estimate
    inputBinding:
      position: 101
      prefix: --vini
outputs:
  - id: output_pdf
    type:
      - 'null'
      - File
    doc: Path to output the pdf file containing plots
    outputBinding:
      glob: $(inputs.output_pdf)
  - id: output_fluxes
    type:
      - 'null'
      - File
    doc: Path to output the flux results
    outputBinding:
      glob: $(inputs.output_fluxes)
  - id: output_stats
    type:
      - 'null'
      - File
    doc: Path to output the khi² test
    outputBinding:
      glob: $(inputs.output_stats)
  - id: output_config
    type:
      - 'null'
      - File
    doc: Path to output the json config file
    outputBinding:
      glob: $(inputs.output_config)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physiofit4galaxy:2.2.1--pyhdfd78af_1
