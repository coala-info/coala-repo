cwlVersion: v1.2
class: CommandLineTool
baseCommand: phlame tree
label: phlame_tree
doc: "Builds a phylogenetic tree from mutation data.\n\nTool homepage: https://github.com/quevan/phlame"
inputs:
  - id: input_mutation_table
    type: File
    doc: Path to input candidate mutation table.
    inputBinding:
      position: 101
      prefix: -i
  - id: input_phylip
    type:
      - 'null'
      - File
    doc: Path to existing phylip file (this will just run RaXML).
    inputBinding:
      position: 101
      prefix: -q
  - id: max_copy_number
    type:
      - 'null'
      - int
    doc: Maximum average copy number to include a position.
    inputBinding:
      position: 101
      prefix: --copynum
  - id: max_frac_ambiguous
    type:
      - 'null'
      - float
    doc: Maximum fraction of ambiguous (N) calls to include a sample.
    inputBinding:
      position: 101
      prefix: --max_frac_ambiguous
  - id: min_allele_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency to make a base call.
    inputBinding:
      position: 101
      prefix: --minAF
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage across a position to make a base call.
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_mapq_score
    type:
      - 'null'
      - int
    doc: Minimum MAPQ score to make a base call.
    inputBinding:
      position: 101
      prefix: --qual
  - id: min_median_coverage_per_position
    type:
      - 'null'
      - int
    doc: Minimum median coverage of position across samples to include.
    inputBinding:
      position: 101
      prefix: --min_cov_position
  - id: min_samples_for_position
    type:
      - 'null'
      - float
    doc: Minimum percent of samples a position must be found in (non-N) to be 
      considered.
    inputBinding:
      position: 101
      prefix: --core
  - id: min_strand_cov
    type:
      - 'null'
      - int
    doc: Minimum per-strand coverage across a position to make a base call.
    inputBinding:
      position: 101
      prefix: --min_strand_cov
  - id: outgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a comma separated list of samples to be considered outgroups; 
      i.e. not included in tree building.
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: remove_recombination
    type:
      - 'null'
      - boolean
    doc: Remove recombination events from the tree.
    inputBinding:
      position: 101
      prefix: --remov_recomb
  - id: renaming_file
    type:
      - 'null'
      - File
    doc: Path to phylip renaming file.
    inputBinding:
      position: 101
      prefix: -r
  - id: rescale
    type:
      - 'null'
      - boolean
    doc: Rescale tree branch lengths into numbers of SNVs.
    inputBinding:
      position: 101
      prefix: --rescale
outputs:
  - id: output_tree
    type:
      - 'null'
      - File
    doc: Path to output tree.
    outputBinding:
      glob: $(inputs.output_tree)
  - id: output_phylip
    type:
      - 'null'
      - File
    doc: Path to output phylip file.
    outputBinding:
      glob: $(inputs.output_phylip)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
