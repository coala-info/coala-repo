cwlVersion: v1.2
class: CommandLineTool
baseCommand: PyCoMo
label: pycomo
doc: "Combine single species/strain models into a community model.\n\nTool homepage:
  https://github.com/univieCUBE/PyCoMo"
inputs:
  - id: abd_file
    type:
      - 'null'
      - File
    doc: a comma separated file containing the input model file names and their 
      abundance. No header should be used in the file.
    inputBinding:
      position: 101
      prefix: --abd-file
  - id: community_name
    type:
      - 'null'
      - string
    doc: the name for the new community model
    inputBinding:
      position: 101
      prefix: --name
  - id: composition_agnostic
    type:
      - 'null'
      - boolean
    doc: run FVA with relaxed constraints, to calculate all possible 
      cross-feeding interactions across all community growth-rates and abundance
      profiles.
    inputBinding:
      position: 101
      prefix: --composition-agnostic
  - id: equal_abd
    type:
      - 'null'
      - boolean
    doc: set abundances to be equal for all community members
    inputBinding:
      position: 101
      prefix: --equal-abd
  - id: fba_flux
    type:
      - 'null'
      - boolean
    doc: run FBA on the community model and store the flux vector in a file
    inputBinding:
      position: 101
      prefix: --fba-flux
  - id: fba_interaction
    type:
      - 'null'
      - boolean
    doc: run FBA on the community model and store the flux of exchange 
      metabolites and whether they are cross-fed in a file
    inputBinding:
      position: 101
      prefix: --fba-interaction
  - id: fraction_of_optimum
    type:
      - 'null'
      - float
    doc: 'set the fraction of optimum that needs to be achieved. Values need to be
      between 0 and 1. Examples: 0 -> 0% of optimum, 0.9 -> 90% of optimum, 1 -> 100%
      of optimum.'
    inputBinding:
      position: 101
      prefix: --fraction-of-optimum
  - id: fva_flux
    type:
      - 'null'
      - type: array
        items: boolean
    doc: run FVA on the exchange metabolites of the community model and store 
      the flux vector in a file.
    inputBinding:
      position: 101
      prefix: --fva-flux
  - id: fva_interaction
    type:
      - 'null'
      - boolean
    doc: run FVA on the community model and store the flux of exchange 
      metabolites and whether they are cross-fed in a file. Set the threshold of
      the objective that needs to be achieved.
    inputBinding:
      position: 101
      prefix: --fva-interaction
  - id: growth_rate
    type:
      - 'null'
      - float
    doc: set a fixed growth-rate for the community
    inputBinding:
      position: 101
      prefix: --growth-rate
  - id: input_models
    type:
      type: array
      items: File
    doc: single species/strain models to combine, either as a directory or 
      separate files
    inputBinding:
      position: 101
      prefix: --input
  - id: is_community
    type:
      - 'null'
      - boolean
    doc: Set this flag if the input model is already a community model.
    inputBinding:
      position: 101
      prefix: --is-community
  - id: log_file
    type:
      - 'null'
      - type: array
        items: File
    doc: set a log file for PyCoMo, located in the output directory (see -o / 
      --output-dir. If used as flag, the file is called 'pycomo.log'.
    inputBinding:
      position: 101
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'set log level. Use one of the following values: error, warning, info, debug'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: loopless
    type:
      - 'null'
      - string
    doc: run FVA with loop correction (on by default)
    inputBinding:
      position: 101
      prefix: --loopless
  - id: match_via_annotation
    type:
      - 'null'
      - string
    doc: the metabolite annotation type to use for matching exchange metabolites
      of different community members (e.g. metanetx.chemical)
    inputBinding:
      position: 101
      prefix: --match-via-annotation
  - id: max_growth_rate
    type:
      - 'null'
      - boolean
    doc: calculate the maximum growth-rate of the community, as well as the 
      community composition reaching it. Results are stored in a csv file.
    inputBinding:
      position: 101
      prefix: --max-growth-rate
  - id: medium
    type:
      - 'null'
      - string
    doc: the medium to be used in the community model, as a comma separated file
      containing a column 'compounds' and a column 'maxFlux'.
    inputBinding:
      position: 101
      prefix: --medium
  - id: num_cores
    type:
      - 'null'
      - int
    doc: the number of cores to be used for FVA
    inputBinding:
      position: 101
      prefix: --num-cores
  - id: precompute_loops
    type:
      - 'null'
      - string
    doc: precompute loop reactions for loopless FVA. Reduces runtime for 
      communities of <10 member, and can lead to numerical issues with GLP 
      solver on larger communities (off by default)
    inputBinding:
      position: 101
      prefix: --precompute-loops
  - id: save_sbml
    type:
      - 'null'
      - boolean
    doc: save the community metabolic model as sbml file
    inputBinding:
      position: 101
      prefix: --save-sbml
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: the output directory to store results (default is the current working 
      directory)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycomo:0.2.9--pyhdfd78af_0
