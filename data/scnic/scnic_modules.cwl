cwlVersion: v1.2
class: CommandLineTool
baseCommand: [SCNIC_analysis.py, modules]
label: scnic_modules
doc: "Make modules on a network\n\nTool homepage: https://github.com/lozuponelab/SCNIC"
inputs:
  - id: input_loc
    type: File
    doc: location of output from SCNIC_analysis.py within
    inputBinding:
      prefix: -i
  - id: output_loc
    type: string
    doc: output directory
    inputBinding:
      prefix: -o
  - id: max_p
    type: ['null', double]
    doc: maximum p-value to determine edges, p must have been calculated
    inputBinding:
      prefix: --max_p
  - id: min_r
    type: ['null', double]
    doc: minimum correlation value to determine edges
    inputBinding:
      prefix: --min_r
  - id: method
    type: ['null', string]
    doc: 'method to be used for determining modules, pick from: naive, k_cliques or louvain (default: naive)'
    inputBinding:
      prefix: --method
  - id: k_size
    type: ['null', int]
    doc: 'k value for use with the k-clique communities algorithm (default: 3)'
    inputBinding:
      prefix: -k
  - id: gamma
    type: ['null', double]
    doc: 'gamma value for use with louvain modularity maximization, between 0 and 1 (default: 0.1)'
    inputBinding:
      prefix: -g
  - id: table_loc
    type: ['null', File]
    doc: biom table used to make network to be collapsed
    inputBinding:
      prefix: --table_loc
  - id: prefix
    type: ['null', string]
    doc: 'prefix for module names in collapsed file (default: module)'
    inputBinding:
      prefix: --prefix
  - id: verbose
    type: ['null', boolean]
    doc: give verbose messages to STDOUT
    inputBinding:
      prefix: -v
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with modules and collapsed table
    outputBinding:
      glob: $(inputs.output_loc)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scnic:0.6.6--pyhdfd78af_0
