cwlVersion: v1.2
class: CommandLineTool
baseCommand: ExpressBetaDiversity
label: expressbetadiversity_ExpressBetaDiversity
doc: "Express Beta Diversity (EBD) for calculating phylogenetic and non-phylogenetic
  beta-diversity, including jackknife replicates and hierarchical clustering.\n\n\
  Tool homepage: https://github.com/dparks1134/ExpressBetaDiversity"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Apply all calculators and cluster calculators at the specified 
      threshold.
    inputBinding:
      position: 101
      prefix: --all
  - id: calculator
    type: string
    doc: Desired calculator (e.g., Bray-Curtis, Canberra).
    inputBinding:
      position: 101
      prefix: --calculator
  - id: clustering
    type:
      - 'null'
      - string
    doc: 'Hierarchical clustering method: UPGMA, SingleLinkage, CompleteLinkage, NJ.'
    default: UPGMA
    inputBinding:
      position: 101
      prefix: --clustering
  - id: count
    type:
      - 'null'
      - boolean
    doc: Use count data as opposed to relative proportions.
    inputBinding:
      position: 101
      prefix: --count
  - id: jackknife
    type:
      - 'null'
      - int
    doc: Number of jackknife replicates to perform.
    default: 0
    inputBinding:
      position: 101
      prefix: --jackknife
  - id: list_calc
    type:
      - 'null'
      - boolean
    doc: List all supported calculators.
    inputBinding:
      position: 101
      prefix: --list-calc
  - id: max_data_vecs
    type:
      - 'null'
      - int
    doc: Maximum number of profiles (data vectors) to have in memory at once.
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-data-vecs
  - id: mrca
    type:
      - 'null'
      - boolean
    doc: Apply 'MRCA weightings' to each branch (experimental).
    inputBinding:
      position: 101
      prefix: --mrca
  - id: sample_size
    type:
      - 'null'
      - boolean
    doc: Print number of sequences in each sample.
    inputBinding:
      position: 101
      prefix: --sample-size
  - id: seq_count_file
    type: File
    doc: Sequence count file.
    inputBinding:
      position: 101
      prefix: --seq-count-file
  - id: seqs_to_draw
    type:
      - 'null'
      - int
    doc: Number of sequence to draw for jackknife replicates.
    inputBinding:
      position: 101
      prefix: --seqs-to-draw
  - id: strict_mrca
    type:
      - 'null'
      - boolean
    doc: Restrict calculator to MRCA subtree.
    inputBinding:
      position: 101
      prefix: --strict-mrca
  - id: threshold
    type:
      - 'null'
      - float
    doc: Correlation threshold for clustering calculators.
    default: 0.8
    inputBinding:
      position: 101
      prefix: --threshold
  - id: tree_file
    type: File
    doc: Tree in Newick format (if phylogenetic beta-diversity is desired).
    inputBinding:
      position: 101
      prefix: --tree-file
  - id: unit_tests
    type:
      - 'null'
      - boolean
    doc: Execute unit tests.
    inputBinding:
      position: 101
      prefix: --unit-tests
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Provide additional information on program execution.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: weighted
    type:
      - 'null'
      - boolean
    doc: Indicates if sequence abundance data should be used.
    inputBinding:
      position: 101
      prefix: --weighted
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output prefix.
    outputBinding:
      glob: $(inputs.output_prefix)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for cluster of calculators.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expressbetadiversity:1.0.10--h9948957_6
