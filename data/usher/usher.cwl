cwlVersion: v1.2
class: CommandLineTool
baseCommand: usher
label: usher
doc: "UShER (v0.6.6)\n\nTool homepage: https://github.com/yatisht/usher"
inputs:
  - id: collapse_output_tree
    type:
      - 'null'
      - boolean
    doc: Collapse internal nodes of the output tree with no mutations before the
      saving the tree to file final-tree.nh in outdir
    inputBinding:
      position: 101
      prefix: --collapse-output-tree
  - id: collapse_tree
    type:
      - 'null'
      - boolean
    doc: Collapse internal nodes of the input tree with no mutations and 
      condense identical sequences in polytomies into a single node and the save
      the tree to file condensed-tree.nh in outdir
    inputBinding:
      position: 101
      prefix: --collapse-tree
  - id: detailed_clades
    type:
      - 'null'
      - boolean
    doc: In clades.txt, write a histogram of annotated clades and counts across 
      all equally parsimonious placements
    inputBinding:
      position: 101
      prefix: --detailed-clades
  - id: load_mutation_annotated_tree
    type:
      - 'null'
      - File
    doc: Load mutation-annotated tree object
    inputBinding:
      position: 101
      prefix: --load-mutation-annotated-tree
  - id: max_parsimony_per_sample
    type:
      - 'null'
      - int
    doc: Maximum parsimony score of the most parsimonious placement(s) allowed 
      per sample beyond which the sample is ignored
    default: 1000000
    inputBinding:
      position: 101
      prefix: --max-parsimony-per-sample
  - id: max_uncertainty_per_sample
    type:
      - 'null'
      - int
    doc: Maximum number of equally parsimonious placements allowed per sample 
      beyond which the sample is ignored
    default: 1000000
    inputBinding:
      position: 101
      prefix: --max-uncertainty-per-sample
  - id: multiple_placements
    type:
      - 'null'
      - int
    doc: Create a new tree up to this limit for each possibility of 
      parsimony-optimal placement
    default: 1
    inputBinding:
      position: 101
      prefix: --multiple-placements
  - id: no_add
    type:
      - 'null'
      - boolean
    doc: Do not add new samples to the tree
    inputBinding:
      position: 101
      prefix: --no-add
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory to dump output and log files
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: retain_input_branch_lengths
    type:
      - 'null'
      - boolean
    doc: Retain the branch lengths from the input tree in out newick files 
      instead of using number of mutations for the branch lengths.
    inputBinding:
      position: 101
      prefix: --retain-input-branch-lengths
  - id: reverse_sort
    type:
      - 'null'
      - boolean
    doc: Reverse the sorting order of sorting options (sort-before-placement-1 
      or sort-before-placement-2) [EXPERIMENTAL]
    inputBinding:
      position: 101
      prefix: --reverse-sort
  - id: sort_before_placement_1
    type:
      - 'null'
      - boolean
    doc: Sort new samples based on computed parsimony score and then number of 
      optimal placements before the actual placement [EXPERIMENTAL].
    inputBinding:
      position: 101
      prefix: --sort-before-placement-1
  - id: sort_before_placement_2
    type:
      - 'null'
      - boolean
    doc: Sort new samples based on the number of optimal placements and then the
      parsimony score before the actual placement [EXPERIMENTAL].
    inputBinding:
      position: 101
      prefix: --sort-before-placement-2
  - id: sort_before_placement_3
    type:
      - 'null'
      - boolean
    doc: Sort new samples based on the number of ambiguous bases [EXPERIMENTAL].
    inputBinding:
      position: 101
      prefix: --sort-before-placement-3
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use when possible
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - File
    doc: Input tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: vcf
    type: File
    doc: Input VCF file (in uncompressed or gzip-compressed .gz format)
    inputBinding:
      position: 101
      prefix: --vcf
  - id: write_parsimony_scores_per_node
    type:
      - 'null'
      - boolean
    doc: Write the parsimony scores for adding new samples at each existing node
      in the tree without modifying the tree in a file names 
      parsimony-scores.tsv in outdir
    inputBinding:
      position: 101
      prefix: --write-parsimony-scores-per-node
  - id: write_single_subtree
    type:
      - 'null'
      - int
    doc: Similar to write-subtrees-size but produces a single subtree with all 
      newly added samples along with random samples up to the value specified by
      this argument
    default: 0
    inputBinding:
      position: 101
      prefix: --write-single-subtree
  - id: write_subtrees_size
    type:
      - 'null'
      - int
    doc: Write minimum set of subtrees covering the newly added samples of size 
      equal to this value
    default: 0
    inputBinding:
      position: 101
      prefix: --write-subtrees-size
  - id: write_uncondensed_final_tree
    type:
      - 'null'
      - boolean
    doc: Write the final tree in uncondensed format and save to file 
      uncondensed-final-tree.nh in outdir
    inputBinding:
      position: 101
      prefix: --write-uncondensed-final-tree
outputs:
  - id: save_mutation_annotated_tree
    type:
      - 'null'
      - File
    doc: Save output mutation-annotated tree object to the specified filename
    outputBinding:
      glob: $(inputs.save_mutation_annotated_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
