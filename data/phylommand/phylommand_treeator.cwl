cwlVersion: v1.2
class: CommandLineTool
baseCommand: treeator
label: phylommand_treeator
doc: "Treeator is a command line program to construct trees using neighbor joining,
  parsimony, or maximum likelihood from similarity matrices or data matrices (fasta,
  nexus, or phylip).\n\nTool homepage: https://github.com/mr-y/phylommand"
inputs:
  - id: data_file_positional
    type:
      - 'null'
      - File
    doc: The data file containing similarity matrix or character data.
    inputBinding:
      position: 1
  - id: alphabet_file
    type:
      - 'null'
      - string
    doc: give file with character alphabet, or dna, protein, or binary for dna, amino
      acid, respectively binary (0 1) alphabets
    default: dna
    inputBinding:
      position: 102
      prefix: --alphabet_file
  - id: data_file
    type:
      - 'null'
      - File
    doc: give the data file.
    inputBinding:
      position: 102
      prefix: --data_file
  - id: file
    type:
      - 'null'
      - File
    doc: give data file name, or if data file name already given, then tree file name.
    inputBinding:
      position: 102
      prefix: --file
  - id: fixed
    type:
      - 'null'
      - string
    doc: give parameter to fix. First parameter is indexed 0. Several parameters can
      be given in a comma separated string, e.g. -e 0,2,3.
    inputBinding:
      position: 102
      prefix: --fixed
  - id: format
    type:
      - 'null'
      - string
    doc: 'give the format of the input files (e.g., phylip,newick). Character options:
      fasta, phylip, nexus. Tree options: newick, nexus.'
    inputBinding:
      position: 102
      prefix: --format
  - id: get_state_at_nodes
    type:
      - 'null'
      - boolean
    doc: will give the states at internal nodes as comments (readable in FigTree).
    inputBinding:
      position: 102
      prefix: --get_state_at_nodes
  - id: likelihood
    type:
      - 'null'
      - boolean
    doc: calculate likelihood for data given tree.
    inputBinding:
      position: 102
      prefix: --likelihood
  - id: model
    type:
      - 'null'
      - string
    doc: give the model by numbering the rate parameters for different transition,
      e.g. -m 0,1,0,2,1,2.
    inputBinding:
      position: 102
      prefix: --model
  - id: neighbour_joining
    type:
      - 'null'
      - boolean
    doc: compute neighbour joining tree for given data. The data should be a left
      triangular similarity matrix.
    inputBinding:
      position: 102
      prefix: --neighbour_joining
  - id: no_branch_length
    type:
      - 'null'
      - boolean
    doc: do not print branch lengths and do not calculate branch lengths for parsimony
      trees.
    inputBinding:
      position: 102
      prefix: --no_branch_length
  - id: no_label
    type:
      - 'null'
      - boolean
    doc: will tell treeator that there are no taxon labels in the similarity matrix.
    inputBinding:
      position: 102
      prefix: --no_label
  - id: no_optim
    type:
      - 'null'
      - boolean
    doc: calculate likelihood for given parameters. No optimization.
    inputBinding:
      position: 102
      prefix: --no_optim
  - id: output_format
    type:
      - 'null'
      - string
    doc: give tree format for output, nexus (nex or x for short) or newick (new or
      w for short).
    default: w
    inputBinding:
      position: 102
      prefix: --output
  - id: parameters
    type:
      - 'null'
      - string
    doc: give corresponding parameter values for parameters. If optimizing these will
      be starting values, e.g. -P 0.1,0.01,0.05.
    inputBinding:
      position: 102
      prefix: --parameters
  - id: parsimony
    type:
      - 'null'
      - boolean
    doc: calculate parsimony score for given tree and data.
    inputBinding:
      position: 102
      prefix: --parsimony
  - id: random
    type:
      - 'null'
      - boolean
    doc: do stepwise addition in random order.
    inputBinding:
      position: 102
      prefix: --random
  - id: step_wise
    type:
      - 'null'
      - boolean
    doc: do parsimony stepwise addition.
    inputBinding:
      position: 102
      prefix: --step_wise
  - id: tree_file
    type:
      - 'null'
      - File
    doc: give tree file name.
    inputBinding:
      position: 102
      prefix: --tree_file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: get additional output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylommand:1.1.0--hc5cd53e_2
stdout: phylommand_treeator.out
