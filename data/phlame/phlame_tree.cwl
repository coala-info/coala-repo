cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phlame
  - tree
label: phlame_tree
doc: "Builds a phylogenetic tree (or a phylip alignment) from a candidate mutation
  table.\n\nTool homepage: https://github.com/quevan/phlame"
inputs:
  - id: input_cmt
    type:
      - 'null'
      - File
    doc: 'Path to input candidate mutation table.'
    inputBinding:
      position: 101
      prefix: -i
  - id: output_tree_path
    type:
      - 'null'
      - string
    doc: 'Path to output tree.'
    inputBinding:
      position: 101
      prefix: -o
  - id: output_phylip_path
    type:
      - 'null'
      - string
    doc: 'Path to output phylip file.'
    inputBinding:
      position: 101
      prefix: -p
  - id: renaming_file_path
    type:
      - 'null'
      - string
    doc: 'Path to phylip renaming file.'
    inputBinding:
      position: 101
      prefix: -r
  - id: input_phylip
    type:
      - 'null'
      - File
    doc: 'Path to existing phylip file (this will just run RaXML).'
    inputBinding:
      position: 101
      prefix: -q
  - id: rescale
    type:
      - 'null'
      - boolean
    doc: 'Rescale tree branch lengths into numbers of SNVs.'
    inputBinding:
      position: 101
      prefix: --rescale
  - id: min_cov
    type:
      - 'null'
      - int
    doc: 'Minimum coverage across a position to make a base call.'
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: minaf
    type:
      - 'null'
      - float
    doc: 'Minimum allele frequency to make a base call.'
    inputBinding:
      position: 101
      prefix: --minAF
  - id: min_strand_cov
    type:
      - 'null'
      - int
    doc: 'Minimum per-strand coverage across a position to make a base call.'
    inputBinding:
      position: 101
      prefix: --min_strand_cov
  - id: qual
    type:
      - 'null'
      - int
    doc: 'Minimum MAPQ score to make a base call.'
    inputBinding:
      position: 101
      prefix: --qual
  - id: core
    type:
      - 'null'
      - float
    doc: 'Minimum percent of samples a position must be found in (non-N) to be considered.'
    inputBinding:
      position: 101
      prefix: --core
  - id: min_cov_position
    type:
      - 'null'
      - int
    doc: 'Minimum median coverage of position across samples to include.'
    inputBinding:
      position: 101
      prefix: --min_cov_position
  - id: max_frac_ambiguous
    type:
      - 'null'
      - float
    doc: 'Maximum fraction of ambiguous (N) calls to include a sample.'
    inputBinding:
      position: 101
      prefix: --max_frac_ambiguous
  - id: copynum
    type:
      - 'null'
      - int
    doc: 'Maximum average copy number to include a position.'
    inputBinding:
      position: 101
      prefix: --copynum
  - id: remov_recomb
    type:
      - 'null'
      - boolean
    doc: 'Remove recombination events from the tree.'
    inputBinding:
      position: 101
      prefix: --remov_recomb
  - id: outgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Specify a comma separated list of samples to be considered outgroups; i.e. not included in tree building.'
    inputBinding:
      position: 101
      prefix: --outgroup
      itemSeparator: ','
outputs:
  - id: output_tree
    type:
      - 'null'
      - File
    doc: Path to output tree.
    outputBinding:
      glob: $(inputs.output_tree_path)
  - id: rescaled_tree
    type:
      - 'null'
      - File
    doc: Tree with branch lengths rescaled to SNVs (written with --rescale).
    outputBinding:
      glob: rescaled_*
  - id: output_phylip
    type:
      - 'null'
      - File
    doc: Path to output phylip file.
    outputBinding:
      glob: $(inputs.output_phylip_path)
  - id: renaming_file
    type:
      - 'null'
      - File
    doc: Path to phylip renaming file.
    outputBinding:
      glob: $(inputs.renaming_file_path)
  - id: regression_plot
    type:
      - 'null'
      - File
    doc: Plot of tree distances against SNV distances (written with --rescale).
    outputBinding:
      glob: tree_snp_distances_linreg.pdf
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
