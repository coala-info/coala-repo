cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_gubbins.py
label: gubbins_run_gubbins
doc: "Gubbins: rapid phylogenetic analysis of large samples of recombinant bacterial whole genome sequences. Detects recombination in a multifasta alignment and builds a recombination-free tree.\n\nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs:
  - id: alignment_filename
    type: File
    doc: "Multifasta alignment file"
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Add a prefix to the final output filenames"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: starting_tree
    type:
      - 'null'
      - File
    doc: "Starting tree"
    inputBinding:
      position: 102
      prefix: --starting-tree
  - id: date
    type:
      - 'null'
      - File
    doc: "Two-column text file in which the second column is the date of isolation in YYYY,YYYY-MM or YYYY-MM-DD format"
    inputBinding:
      position: 103
      prefix: --date
  - id: use_time_stamp
    type:
      - 'null'
      - boolean
    doc: "Use a time stamp in file names"
    inputBinding:
      position: 104
      prefix: --use-time-stamp
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for parallelisation"
    inputBinding:
      position: 105
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Turn on debugging"
    inputBinding:
      position: 106
      prefix: --verbose
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "Do not cleanup intermediate files"
    inputBinding:
      position: 107
      prefix: --no-cleanup
  - id: pairwise
    type:
      - 'null'
      - boolean
    doc: "Compare two sequences (without using a tree)"
    inputBinding:
      position: 108
      prefix: --pairwise
  - id: filter_percentage
    type:
      - 'null'
      - float
    doc: "Filter out taxa with more than this percentage of gaps"
    inputBinding:
      position: 109
      prefix: --filter-percentage
  - id: remove_identical_sequences
    type:
      - 'null'
      - boolean
    doc: "Remove identical sequences"
    inputBinding:
      position: 110
      prefix: --remove-identical-sequences
  - id: tree_builder
    type:
      - 'null'
      - string
    doc: "Application to use for tree building: raxml, raxmlng, iqtree, iqtree-fast, fasttree, hybrid, rapidnj or veryfasttree"
    inputBinding:
      position: 111
      prefix: --tree-builder
  - id: tree_args
    type:
      - 'null'
      - string
    doc: "Quoted string of further arguments passed to tree building algorithm"
    inputBinding:
      position: 112
      prefix: --tree-args
  - id: first_tree_builder
    type:
      - 'null'
      - string
    doc: "Application to use for building the first tree: raxml, raxmlng, iqtree, iqtree-fast, fasttree, rapidnj, star or veryfasttree"
    inputBinding:
      position: 113
      prefix: --first-tree-builder
  - id: first_tree_args
    type:
      - 'null'
      - string
    doc: "Further arguments passed to first tree building algorithm"
    inputBinding:
      position: 114
      prefix: --first-tree-args
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "Outgroup name for rerooting. A list of comma separated names can be used if they form a clade"
    inputBinding:
      position: 115
      prefix: --outgroup
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: "Number of bootstrap replicates to perform with final alignment"
    inputBinding:
      position: 116
      prefix: --bootstrap
  - id: transfer_bootstrap
    type:
      - 'null'
      - boolean
    doc: "Calculate bootstrap supporting transfer bootstrap expectation"
    inputBinding:
      position: 117
      prefix: --transfer-bootstrap
  - id: sh_test
    type:
      - 'null'
      - boolean
    doc: "Perform an SH test of node likelihoods"
    inputBinding:
      position: 118
      prefix: --sh-test
  - id: seed
    type:
      - 'null'
      - int
    doc: "Set seed for reproducibility of analysis"
    inputBinding:
      position: 119
      prefix: --seed
  - id: invariant_site_correction
    type:
      - 'null'
      - boolean
    doc: "Correct for invariant sites"
    inputBinding:
      position: 120
      prefix: --invariant-site-correction
  - id: model
    type:
      - 'null'
      - string
    doc: "Nucleotide substitution model: JC, K2P, HKY, GTR, GTRGAMMA or GTRCAT (not all available for all tree building algorithms)"
    inputBinding:
      position: 121
      prefix: --model
  - id: first_model
    type:
      - 'null'
      - string
    doc: "Nucleotide substitution model used for first tree: JC, K2P, HKY, GTR, GTRGAMMA or GTRCAT"
    inputBinding:
      position: 122
      prefix: --first-model
  - id: best_model
    type:
      - 'null'
      - boolean
    doc: "Automatically select best substitution model using iqtree in later iterations"
    inputBinding:
      position: 123
      prefix: --best-model
  - id: custom_model
    type:
      - 'null'
      - string
    doc: "String corresponding to a substitution model for the selected tree building algorithm"
    inputBinding:
      position: 124
      prefix: --custom-model
  - id: custom_first_model
    type:
      - 'null'
      - string
    doc: "String corresponding to a substitution model for the selected tree building algorithm for the first iteration"
    inputBinding:
      position: 125
      prefix: --custom-first-model
  - id: model_fitter
    type:
      - 'null'
      - string
    doc: "Application to use for model fitting for joint ancestral state reconstruction: raxml, raxmlng, iqtree, fasttree or None"
    inputBinding:
      position: 126
      prefix: --model-fitter
  - id: recon_model
    type:
      - 'null'
      - string
    doc: "Nucleotide substitution model used for ancestral state reconstruction: JC, K2P, HKY, GTR, GTRGAMMA or GTRCAT"
    inputBinding:
      position: 127
      prefix: --recon-model
  - id: custom_recon_model
    type:
      - 'null'
      - string
    doc: "String corresponding to a substitution model for the selected model fitting algorithm"
    inputBinding:
      position: 128
      prefix: --custom-recon-model
  - id: recon_with_dates
    type:
      - 'null'
      - boolean
    doc: "Use isolate date information in ancestral joint sequence reconstruction"
    inputBinding:
      position: 129
      prefix: --recon-with-dates
  - id: model_fitter_args
    type:
      - 'null'
      - string
    doc: "Further arguments passed to model fitting algorithm"
    inputBinding:
      position: 130
      prefix: --model-fitter-args
  - id: mar
    type:
      - 'null'
      - boolean
    doc: "Use marginal, rather than joint, ancestral reconstruction"
    inputBinding:
      position: 131
      prefix: --mar
  - id: seq_recon
    type:
      - 'null'
      - string
    doc: "Algorithm to use for marginal reconstruction (requires --mar): raxml, raxmlng, iqtree or None"
    inputBinding:
      position: 132
      prefix: --seq-recon
  - id: seq_recon_args
    type:
      - 'null'
      - string
    doc: "Further arguments passed to sequence reconstruction algorithm"
    inputBinding:
      position: 133
      prefix: --seq-recon-args
  - id: min_snps
    type:
      - 'null'
      - int
    doc: "Min SNPs to identify a recombination block"
    inputBinding:
      position: 134
      prefix: --min-snps
  - id: min_window_size
    type:
      - 'null'
      - int
    doc: "Minimum window size"
    inputBinding:
      position: 135
      prefix: --min-window-size
  - id: max_window_size
    type:
      - 'null'
      - int
    doc: "Maximum window size"
    inputBinding:
      position: 136
      prefix: --max-window-size
  - id: p_value
    type:
      - 'null'
      - float
    doc: "Uncorrected p value used to identify recombinations"
    inputBinding:
      position: 137
      prefix: --p-value
  - id: trimming_ratio
    type:
      - 'null'
      - float
    doc: "Ratio of log probabilities used to trim recombinations"
    inputBinding:
      position: 138
      prefix: --trimming-ratio
  - id: extensive_search
    type:
      - 'null'
      - boolean
    doc: "Undertake slower, more thorough, search for recombination"
    inputBinding:
      position: 139
      prefix: --extensive-search
  - id: iterations
    type:
      - 'null'
      - int
    doc: "Maximum No. of iterations"
    inputBinding:
      position: 140
      prefix: --iterations
  - id: converge_method
    type:
      - 'null'
      - string
    doc: "Criteria to use to know when to halt iterations: weighted_robinson_foulds, robinson_foulds or recombination"
    inputBinding:
      position: 141
      prefix: --converge-method
  - id: resume
    type:
      - 'null'
      - File
    doc: "Intermediate tree from previous run (must include \"iteration_X\" in file name)"
    inputBinding:
      position: 142
      prefix: --resume
outputs:
  - id: final_tree
    type: File
    doc: "Final tree after the last iteration"
    outputBinding:
      glob: "*.final_tree.tre"
      outputEval: $(self.filter(function(f) { return f.basename.indexOf('node_labelled') < 0; })[0])
  - id: node_labelled_final_tree
    type: File
    doc: "Final tree with labelled internal nodes"
    outputBinding:
      glob: "*.node_labelled.final_tree.tre"
  - id: recombination_gff
    type: File
    doc: "GFF of the predicted recombination blocks"
    outputBinding:
      glob: "*.recombination_predictions.gff"
  - id: recombination_embl
    type: File
    doc: "EMBL file of the predicted recombination blocks"
    outputBinding:
      glob: "*.recombination_predictions.embl"
  - id: branch_base_reconstruction
    type: File
    doc: "EMBL file with the base reconstruction of each branch"
    outputBinding:
      glob: "*.branch_base_reconstruction.embl"
  - id: per_branch_statistics
    type: File
    doc: "Per branch recombination statistics (CSV)"
    outputBinding:
      glob: "*.per_branch_statistics.csv"
  - id: filtered_polymorphic_sites
    type: File
    doc: "Filtered polymorphic sites alignment (FASTA)"
    outputBinding:
      glob: "*.filtered_polymorphic_sites.fasta"
  - id: snp_distribution_vcf
    type: File
    doc: "VCF with the distribution of SNPs"
    outputBinding:
      glob: "*.summary_of_snp_distribution.vcf"
  - id: log
    type: File
    doc: "Log with the programs used and their citations"
    outputBinding:
      glob: "*.log"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
