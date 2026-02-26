cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpinsim simulate
label: cpinsim_simulate
doc: "Simulates protein interaction networks.\n\nTool homepage: https://github.com/BiancaStoecker/cpinsim"
inputs:
  - id: proteins
    type: File
    doc: Path to a csv-file containing the parsed proteins.
    inputBinding:
      position: 1
  - id: association_probability
    type:
      - 'null'
      - float
    doc: The probability for a new association between two proteins
    default: 0.005
    inputBinding:
      position: 102
      prefix: --association-probability
  - id: concentrations
    type:
      - 'null'
      - string
    doc: Maximum number of protein instances and path to a csv-file containing a
      concentration for each protein.
    inputBinding:
      position: 102
      prefix: --concentrations
  - id: dissociation_probability
    type:
      - 'null'
      - float
    doc: The probability for a dissociation of a pairwise interaction
    default: 0.0125
    inputBinding:
      position: 102
      prefix: --dissociation-probability
  - id: max_steps
    type:
      - 'null'
      - int
    doc: Maximum number of simulation steps if convergence is not reached until 
      then
    default: 1000
    inputBinding:
      position: 102
      prefix: --max-steps
  - id: number_of_copies
    type:
      - 'null'
      - int
    doc: Number of copies for each protein type.
    inputBinding:
      position: 102
      prefix: --number-of-copies
  - id: perturbation
    type:
      - 'null'
      - type: array
        items: string
    doc: Protein that should be overexpressed or down regulated by factor FACTOR
      for perturbation analysis.
    inputBinding:
      position: 102
      prefix: --perturbation
outputs:
  - id: output_graph
    type:
      - 'null'
      - File
    doc: Pickle the complete graph at the end of simulation (after last 
      dissociation step) and write it to the given path.
    outputBinding:
      glob: $(inputs.output_graph)
  - id: output_log
    type:
      - 'null'
      - File
    doc: Write some log information of each simulation stept to the given path. 
      If not specified, std-out is used.
    outputBinding:
      glob: $(inputs.output_log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpinsim:0.5.2--py36_1
