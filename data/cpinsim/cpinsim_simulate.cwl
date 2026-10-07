cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpinsim
  - simulate
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
    inputBinding:
      position: 102
      prefix: --association-probability
  - id: max_protein_instances
    type:
      - 'null'
      - int
    doc: Maximum number of protein instances; first value of --concentrations. 
      Give it together with concentrations_file.
    inputBinding:
      position: 105
      prefix: --concentrations
  - id: concentrations_file
    type:
      - 'null'
      - File
    doc: Csv-file containing a concentration for each protein; second value of 
      --concentrations. Give it together with max_protein_instances.
    inputBinding:
      position: 106
  - id: dissociation_probability
    type:
      - 'null'
      - float
    doc: The probability for a dissociation of a pairwise interaction
    inputBinding:
      position: 102
      prefix: --dissociation-probability
  - id: max_steps
    type:
      - 'null'
      - int
    doc: Maximum number of simulation steps if convergence is not reached until 
      then
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
        items:
          type: array
          items: string
        inputBinding:
          prefix: --perturbation
    doc: Protein that should be overexpressed or down regulated by factor FACTOR
      for perturbation analysis. Each item is a pair [PROTEIN, FACTOR], e.g. 
      [[FYN, '0'], [ABL1, '5']]; each pair becomes one --perturbation option.
    inputBinding:
      position: 102
  - id: output_graph_path
    type: string
    doc: Path for the pickled (gzipped) graph at the end of simulation.
    inputBinding:
      position: 103
      prefix: --output-graph
  - id: output_log_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --output-log
outputs:
  - id: output_graph
    type: File
    doc: Pickle the complete graph at the end of simulation (after last 
      dissociation step) and write it to the given path.
    outputBinding:
      glob: $(inputs.output_graph_path)
  - id: output_log
    type:
      - 'null'
      - File
    doc: Write some log information of each simulation stept to the given path. 
      If not specified, std-out is used.
    outputBinding:
      glob: $(inputs.output_log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpinsim:0.5.2--py36_1
