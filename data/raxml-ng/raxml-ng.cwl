cwlVersion: v1.2
class: CommandLineTool
baseCommand: raxml-ng
label: raxml-ng
doc: "RAxML-NG is a phylogenetic tree inference tool which uses maximum-likelihood (ML) optimality criterion.\n\nTool homepage: https://github.com/amkozlov/raxml-ng"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: "all-in-one (ML search + bootstrapping)"
    inputBinding:
      position: 101
      prefix: --all
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: "bootstrapping (default: use bootstopping to auto-detect #replicates)"
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: evaluate
    type:
      - 'null'
      - boolean
    doc: "evaluate the likelihood of a tree (with model+brlen optimization)"
    inputBinding:
      position: 101
      prefix: --evaluate
  - id: parse
    type:
      - 'null'
      - boolean
    doc: "parse alignment, compress patterns and create binary MSA file"
    inputBinding:
      position: 101
      prefix: --parse
  - id: search
    type:
      - 'null'
      - boolean
    doc: "ML tree search (default: 10 parsimony + 10 random starting trees)"
    inputBinding:
      position: 101
      prefix: --search
  - id: support
    type:
      - 'null'
      - boolean
    doc: "compute bipartition support for a given reference tree and a set of replicate trees"
    inputBinding:
      position: 101
      prefix: --support
  - id: bsconverge
    type:
      - 'null'
      - boolean
    doc: "test for bootstrapping convergence using autoMRE criterion"
    inputBinding:
      position: 101
      prefix: --bsconverge
  - id: bsmsa
    type:
      - 'null'
      - boolean
    doc: "generate bootstrap replicate MSAs"
    inputBinding:
      position: 101
      prefix: --bsmsa
  - id: terrace
    type:
      - 'null'
      - boolean
    doc: "check whether a tree lies on a phylogenetic terrace"
    inputBinding:
      position: 101
      prefix: --terrace
  - id: check
    type:
      - 'null'
      - boolean
    doc: "check alignment correctness and remove empty columns/rows"
    inputBinding:
      position: 101
      prefix: --check
  - id: start
    type:
      - 'null'
      - boolean
    doc: "generate parsimony/random starting trees and exit"
    inputBinding:
      position: 101
      prefix: --start
  - id: rfdist
    type:
      - 'null'
      - boolean
    doc: "compute pair-wise Robinson-Foulds (RF) distances between trees"
    inputBinding:
      position: 101
      prefix: --rfdist
  - id: ancestral
    type:
      - 'null'
      - boolean
    doc: "ancestral state reconstruction at all inner nodes"
    inputBinding:
      position: 101
      prefix: --ancestral
  - id: sitelh
    type:
      - 'null'
      - boolean
    doc: "print per-site log-likelihood values"
    inputBinding:
      position: 101
      prefix: --sitelh
  - id: search1
    type:
      - 'null'
      - boolean
    doc: "alias for: --search --tree rand{1}"
    inputBinding:
      position: 101
      prefix: --search1
  - id: loglh
    type:
      - 'null'
      - boolean
    doc: "alias for: --evaluate --opt-model off --opt-branches off --nofiles --log result"
    inputBinding:
      position: 101
      prefix: --loglh
  - id: rf
    type:
      - 'null'
      - boolean
    doc: "alias for: --rfdist --nofiles --log result"
    inputBinding:
      position: 101
      prefix: --rf
  - id: consense
    type:
      - 'null'
      - string
    doc: "build strict, majority-rule (MR) or extended MR (MRE) consensus tree: STRICT, MR, MR<n> or MRE (default: MR); use with a tree file of replicate trees"
    inputBinding:
      position: 101
      prefix: --consense
  - id: tree
    type:
      - 'null'
      - File
    doc: "starting tree (newick file), or the input tree(s) of the selected command"
    inputBinding:
      position: 101
      prefix: --tree
  - id: tree_spec
    type:
      - 'null'
      - string
    doc: "starting tree: rand{N} or pars{N}, N = number of trees (default: rand{10},pars{10})"
    inputBinding:
      position: 101
      prefix: --tree
  - id: msa
    type:
      - 'null'
      - File
    doc: "alignment file"
    inputBinding:
      position: 101
      prefix: --msa
  - id: msa_format
    type:
      - 'null'
      - string
    doc: "alignment file format: FASTA, PHYLIP, CATG or AUTO (default)"
    inputBinding:
      position: 101
      prefix: --msa-format
  - id: data_type
    type:
      - 'null'
      - string
    doc: "data type: DNA, AA, BIN or AUTO (default)"
    inputBinding:
      position: 101
      prefix: --data-type
  - id: tree_constraint
    type:
      - 'null'
      - File
    doc: "constraint tree"
    inputBinding:
      position: 101
      prefix: --tree-constraint
  - id: prefix_path
    type: string
    doc: "prefix for output files (default: MSA file name)"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: log
    type:
      - 'null'
      - string
    doc: "log verbosity: ERROR, WARNING, RESULT, INFO, PROGRESS, DEBUG (default: PROGRESS)"
    inputBinding:
      position: 101
      prefix: --log
  - id: redo
    type:
      - 'null'
      - boolean
    doc: "overwrite existing result files and ignore checkpoints"
    inputBinding:
      position: 101
      prefix: --redo
  - id: nofiles
    type:
      - 'null'
      - boolean
    doc: "do not create any output files, print results to the terminal only"
    inputBinding:
      position: 101
      prefix: --nofiles
  - id: precision
    type:
      - 'null'
      - int
    doc: "number of decimal places to print (default: 6)"
    inputBinding:
      position: 101
      prefix: --precision
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "comma-separated list of outgroup taxon names (a drawing option)"
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: site_weights
    type:
      - 'null'
      - File
    doc: "file with MSA column weights (positive integers only)"
    inputBinding:
      position: 101
      prefix: --site-weights
  - id: seed
    type:
      - 'null'
      - int
    doc: "seed for pseudo-random number generator (default: current time)"
    inputBinding:
      position: 101
      prefix: --seed
  - id: pat_comp
    type:
      - 'null'
      - string
    doc: "alignment pattern compression: on | off (default: on)"
    inputBinding:
      position: 101
      prefix: --pat-comp
  - id: tip_inner
    type:
      - 'null'
      - string
    doc: "tip-inner case optimization: on | off (default: off)"
    inputBinding:
      position: 101
      prefix: --tip-inner
  - id: site_repeats
    type:
      - 'null'
      - string
    doc: "site repeats optimization: on | off (default: on)"
    inputBinding:
      position: 101
      prefix: --site-repeats
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of parallel threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: workers
    type:
      - 'null'
      - int
    doc: "number of tree searches to run in parallel (default: 1)"
    inputBinding:
      position: 101
      prefix: --workers
  - id: simd
    type:
      - 'null'
      - string
    doc: "vector instruction set to use: none | sse3 | avx | avx2 (default: auto-detect)"
    inputBinding:
      position: 101
      prefix: --simd
  - id: rate_scalers
    type:
      - 'null'
      - string
    doc: "individual CLV scalers for each rate category: on | off"
    inputBinding:
      position: 101
      prefix: --rate-scalers
  - id: force
    type:
      - 'null'
      - string
    doc: "disable safety checks (list of checks)"
    inputBinding:
      position: 101
      prefix: --force
  - id: model
    type:
      - 'null'
      - string
    doc: "model specification, e.g. GTR+G (or the name of a partition file, see model_file)"
    inputBinding:
      position: 101
      prefix: --model
  - id: model_file
    type:
      - 'null'
      - File
    doc: "partition file with the model specification"
    inputBinding:
      position: 101
      prefix: --model
  - id: brlen
    type:
      - 'null'
      - string
    doc: "branch length linkage between partitions: linked | scaled | unlinked (default: scaled)"
    inputBinding:
      position: 101
      prefix: --brlen
  - id: blmin
    type:
      - 'null'
      - float
    doc: "minimum branch length (default: 1e-6)"
    inputBinding:
      position: 101
      prefix: --blmin
  - id: blmax
    type:
      - 'null'
      - float
    doc: "maximum branch length (default: 100)"
    inputBinding:
      position: 101
      prefix: --blmax
  - id: blopt
    type:
      - 'null'
      - string
    doc: "branch length optimization method: nr_fast | nr_safe | nr_oldfast | nr_oldsafe (default: nr_fast)"
    inputBinding:
      position: 101
      prefix: --blopt
  - id: opt_model
    type:
      - 'null'
      - string
    doc: "ML optimization of all model parameters: on | off (default: on)"
    inputBinding:
      position: 101
      prefix: --opt-model
  - id: opt_branches
    type:
      - 'null'
      - string
    doc: "ML optimization of all branch lengths: on | off (default: on)"
    inputBinding:
      position: 101
      prefix: --opt-branches
  - id: prob_msa
    type:
      - 'null'
      - string
    doc: "use probabilistic alignment (works with CATG and VCF): on | off"
    inputBinding:
      position: 101
      prefix: --prob-msa
  - id: lh_epsilon
    type:
      - 'null'
      - float
    doc: "log-likelihood epsilon for optimization/tree search (default: 0.1)"
    inputBinding:
      position: 101
      prefix: --lh-epsilon
  - id: spr_radius
    type:
      - 'null'
      - string
    doc: "SPR re-insertion radius for fast iterations (default: AUTO)"
    inputBinding:
      position: 101
      prefix: --spr-radius
  - id: spr_cutoff
    type:
      - 'null'
      - string
    doc: "relative LH cutoff for descending into subtrees, or off (default: 1.0)"
    inputBinding:
      position: 101
      prefix: --spr-cutoff
  - id: lh_epsilon_triplet
    type:
      - 'null'
      - float
    doc: "log-likelihood epsilon for branch length triplet optimization (default: 1000)"
    inputBinding:
      position: 101
      prefix: --lh-epsilon-triplet
  - id: bs_trees
    type:
      - 'null'
      - string
    doc: "number of bootstrap replicates, or autoMRE{N} for the MRE-based convergence criterion (default: 1000)"
    inputBinding:
      position: 101
      prefix: --bs-trees
  - id: bs_trees_file
    type:
      - 'null'
      - File
    doc: "Newick file containing a set of bootstrap replicate trees (with --support)"
    inputBinding:
      position: 101
      prefix: --bs-trees
  - id: bs_cutoff
    type:
      - 'null'
      - float
    doc: "cutoff threshold for the MRE-based bootstopping criteria (default: 0.03)"
    inputBinding:
      position: 101
      prefix: --bs-cutoff
  - id: bs_metric
    type:
      - 'null'
      - string
    doc: "branch support metric: fbp (Felsenstein bootstrap, default) | tbe (transfer distance)"
    inputBinding:
      position: 101
      prefix: --bs-metric
  - id: bs_write_msa
    type:
      - 'null'
      - string
    doc: "write all bootstrap alignments: on | off (default: off)"
    inputBinding:
      position: 101
      prefix: --bs-write-msa
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix
    type:
      - 'null'
      - type: array
        items: File
    doc: Prefix for all output files
    outputBinding:
      glob: $(inputs.prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raxml-ng:1.2.2--h6747034_2
stdout: raxml-ng_stdout.txt
