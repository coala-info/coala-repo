cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_and_solve_iso2flux_model.py
label: iso2flux
doc: "Creates and solves an iso2flux model.\n\nTool homepage: https://github.com/cfoguet/iso2flux"
inputs:
  - id: experimental_data_file
    type: File
    doc: Experimental isotopologue data file (CSV or XLSX).
    inputBinding:
      position: 1
      prefix: -e
  - id: label_propagation_rules
    type: ['null', File]
    doc: Label propagation rules file (CSV or XLSX). The script looks for simple_label_model.xlsx when it is not given.
    inputBinding:
      position: 2
      prefix: -l
  - id: constraint_based_model
    type: ['null', File]
    doc: Constraint-based model (SBML, CSV or XLSX). The script looks for simple_model.sbml when it is not given.
    inputBinding:
      position: 3
      prefix: -c
  - id: flux_constraints
    type: ['null', File]
    doc: Flux constraints file (CSV or XLSX).
    inputBinding:
      position: 4
      prefix: -f
  - id: output_name
    type: string
    default: Iso2Flux
    doc: Prefix of the output files.
    inputBinding:
      position: 5
      prefix: -o
  - id: eqn_dir
    type: ['null', string]
    doc: Name of the directory for the generated equations.
    inputBinding:
      position: 6
      prefix: -q
  - id: max_reversible_turnover
    type: ['null', float]
    doc: Maximum turnover of reversible reactions.
    inputBinding:
      position: 7
      prefix: -t
  - id: validate
    type: ['null', boolean]
    doc: Only validate the model.
    inputBinding:
      position: 8
      prefix: -v
  - id: number_of_processes
    type: ['null', int]
    doc: Number of processes.
    inputBinding:
      position: 9
      prefix: -n
  - id: population_size
    type: ['null', int]
    doc: Population size of the optimizer.
    inputBinding:
      position: 10
      prefix: -p
  - id: generations_per_cycle
    type: ['null', int]
    doc: Generations per cycle of the optimizer.
    inputBinding:
      position: 11
      prefix: -g
  - id: max_cycles_without_improvement
    type: ['null', int]
    doc: Maximum number of cycles without improvement.
    inputBinding:
      position: 12
      prefix: -m
  - id: compute_confidence_intervals
    type: ['null', boolean]
    doc: Compute flux confidence intervals.
    inputBinding:
      position: 13
      prefix: -i
  - id: incubation_time
    type: ['null', float]
    doc: Incubation time of the experimental data to use.
    inputBinding:
      position: 14
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: fluxes
    type: ['null', File]
    doc: Estimated fluxes.
    outputBinding:
      glob: $(inputs.output_name)_fluxes.csv
  - id: label_results
    type: ['null', File]
    doc: Simulated label (isotopologue) results.
    outputBinding:
      glob: $(inputs.output_name)_label.csv
  - id: constrained_model
    type: ['null', File]
    doc: Constrained SBML model.
    outputBinding:
      glob: $(inputs.output_name)_constrained_model.xml
  - id: variables
    type: ['null', File]
    doc: Optimal variable values.
    outputBinding:
      glob: $(inputs.output_name)_variables.txt
  - id: flux_intervals
    type: ['null', File]
    doc: Flux confidence intervals.
    outputBinding:
      glob: $(inputs.output_name)_flux_interval.csv
  - id: other_outputs
    type:
      type: array
      items: File
    doc: Other result files (iso2flux model, validation, penalty files).
    outputBinding:
      glob: $(inputs.output_name)*.iso2flux*
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/iso2flux:phenomenal-v0.7.1_cv2.1.60
stdout: iso2flux.out
