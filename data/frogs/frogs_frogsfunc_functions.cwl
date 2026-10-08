cwlVersion: v1.2
class: CommandLineTool
baseCommand: frogsfunc_functions.py
label: frogs_frogsfunc_functions
doc: "Per-sample functional profiles prediction.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: nb_cpus
    type: ['null', int]
    doc: "The maximum number of CPUs used. [Default: 1]"
    inputBinding:
      position: 2
      prefix: --nb-cpus
  - id: strat_contrib
    type: ['null', boolean]
    doc: "If activated, a new table is built:contribution of each ASV in each sample in each function abundances. [Default: False]"
    inputBinding:
      position: 3
      prefix: --strat-contrib
  - id: input_biom
    type: File
    doc: "frogsfunc_placeseqs Biom output file (frogsfunc_placeseqs.biom)."
    inputBinding:
      position: 4
      prefix: --input-biom
  - id: input_fasta
    type: File
    doc: "frogsfunc_placeseqs Fasta output file (frogsfunc_placeseqs.fasta)."
    inputBinding:
      position: 5
      prefix: --input-fasta
  - id: input_tree
    type: File
    doc: "frogsfunc_placeseqs output tree in newick format containing both studied sequences (i.e. ASVs) and reference sequences."
    inputBinding:
      position: 6
      prefix: --input-tree
  - id: input_marker_copy
    type: File
    doc: "Table of predicted marker gene copy numbers (frogsfunc_placeseqs output : frogsfunc_marker_copy_per_asv.tsv)."
    inputBinding:
      position: 7
      prefix: --input-marker-copy
  - id: marker_type
    type: {type: enum, symbols: ['16S', ITS, '18S']}
    doc: "Marker gene to be analyzed."
    inputBinding:
      position: 8
      prefix: --marker-type
  - id: hsp_method
    type: ['null', {type: enum, symbols: [mp, emp_prob, pic, scp, subtree_average]}]
    doc: "HSP method to use. mp: predict discrete traits using max parsimony. emp_prob: predict discrete traits based on empirical state probabilities across tips. subtree_average: predict continuous traits using subtree averaging. pic: predict continuous traits with phylogentic independent contrast. scp: reconstruct continuous traits using squared-change parsimony [Default: mp]."
    inputBinding:
      position: 9
      prefix: --hsp-method
  - id: max_nsti
    type: ['null', float]
    doc: "Sequences with NSTI values above this value will be excluded [Default: 2.0]."
    inputBinding:
      position: 10
      prefix: --max-nsti
  - id: min_blast_ident
    type: ['null', float]
    doc: "Sequences with blast percentage identity against the PICRUSt2 closest ref above this value will be excluded (between 0 and 1). [Default: None]"
    inputBinding:
      position: 11
      prefix: --min-blast-ident
  - id: min_blast_cov
    type: ['null', float]
    doc: "Sequences with blast percentage coverage against the PICRUSt2 closest ref above this value will be excluded (between 0 and 1). [Default: None]"
    inputBinding:
      position: 12
      prefix: --min-blast-cov
  - id: min_reads
    type: ['null', int]
    doc: "Minimum number of reads across all samples for each input ASV. ASVs below this cut-off will be counted as part of the \"RARE\" category in the stratified output. If you choose 1, none ASV will be grouped in \u201cRARE\u201d category. [Default: 1]."
    inputBinding:
      position: 13
      prefix: --min-reads
  - id: min_samples
    type: ['null', int]
    doc: "Minimum number of samples that an ASV needs to be identfied within. ASVs below this cut-off will be counted as part of the \"RARE\" category in the stratified output. If you choose 1, none ASV will be grouped in \u201cRARE\u201d category. [Default: 1]."
    inputBinding:
      position: 14
      prefix: --min-samples
  - id: functions
    type: ['null', {type: array, items: {type: enum, symbols: [EC, KO, COG, PFAM, TIGRFAM, PHENO]}}]
    doc: "Specifies which function databases should be used. EC is used by default because it is necessary for frogsfunc_pathways. At least EC or KO is required.[Default: ['EC']]"
    inputBinding:
      position: 15
      prefix: --functions
  - id: input_function_table
    type: ['null', File]
    doc: "The path to input functions table describing directly observed functions, in tab-delimited format.(ex $PICRU St2_PATH/default_files/fungi/ec_ITS_counts.txt.gz)."
    inputBinding:
      position: 16
      prefix: --input-function-table
  - id: prefix_function_abund_path
    type: ['null', string]
    doc: "prefix for function abundances table and function copy numbers(TSV format). [Default: unstrat_abundance]."
    inputBinding:
      position: 17
      prefix: --prefix-function-abund
  - id: prefix_contrib_path
    type: ['null', string]
    doc: "prefix for stratified ASV contribution in function abundances. Warning this output is memory intensive and so only generated if --stat-out is used [Default: strat_contrib_and_abundance]"
    inputBinding:
      position: 18
      prefix: --prefix-contrib
  - id: output_asv_copy_norm_path
    type: ['null', string]
    doc: "Output file with asv abundances normalized by marker copies number. [Default: frogsfunc_functions_asv_ccopy_norm_abundance.tsv]"
    inputBinding:
      position: 19
      prefix: --output-asv-copy-norm
  - id: output_weighted_nsti_path
    type: ['null', string]
    doc: "Output file with the mean of nsti value per sample (format: TSV). [Default: frogsfunc_functions_weighted_nsti.tsv]"
    inputBinding:
      position: 20
      prefix: --output-weighted-nsti
  - id: output_biom_path
    type: ['null', string]
    doc: "Biom file of kept ASVs (NSTI, blast perc identity or blast perc coverage thresholds). (format: BIOM) [Default: frogsfunc_function_asv_abundance.biom]"
    inputBinding:
      position: 21
      prefix: --output-biom
  - id: output_fasta_path
    type: ['null', string]
    doc: "Fasta file of kept ASVs (NSTI, blast perc identity or blast perc coverage thresholds). (format: FASTA). [Default: frogsfunc_function_asv.fasta]"
    inputBinding:
      position: 22
      prefix: --output-fasta
  - id: output_excluded_path
    type: ['null', string]
    doc: "List of ASVs with NSTI values above NSTI threshold ( --max_NSTI NSTI ).[Default: frogsfunc_functions_asv_excluded.txt]"
    inputBinding:
      position: 23
      prefix: --output-excluded
  - id: log_file_path
    type: ['null', string]
    doc: "List of commands executed. [Default: stdout]"
    inputBinding:
      position: 24
      prefix: --log-file
  - id: html_path
    type: ['null', string]
    doc: "Path to store resulting html file. [Default: frogsfunc_functions_summary.html]"
    inputBinding:
      position: 25
      prefix: --html
outputs:
  - id: prefix_function_abund
    type: ['null', {type: array, items: File}]
    doc: "prefix for function abundances table and function copy numbers(TSV format). [Default: unstrat_abundance]."
    outputBinding:
      glob: '${ var p = inputs.prefix_function_abund_path ? inputs.prefix_function_abund_path : ''unstrat_abundance''; return p + ''*''; }'
  - id: prefix_contrib
    type: ['null', {type: array, items: File}]
    doc: "prefix for stratified ASV contribution in function abundances. Warning this output is memory intensive and so only generated if --stat-out is used [Default: strat_contrib_and_abundance]"
    outputBinding:
      glob: '${ var p = inputs.prefix_contrib_path ? inputs.prefix_contrib_path : ''strat_contrib_and_abundance''; return p + ''*''; }'
  - id: output_asv_copy_norm
    type: ['null', File]
    doc: "Output file with asv abundances normalized by marker copies number. [Default: frogsfunc_functions_asv_ccopy_norm_abundance.tsv]"
    outputBinding:
      glob: '${ return inputs.output_asv_copy_norm_path ? inputs.output_asv_copy_norm_path : ''frogsfunc_functions_asv_ccopy_norm_abundance.tsv''; }'
  - id: output_weighted_nsti
    type: ['null', File]
    doc: "Output file with the mean of nsti value per sample (format: TSV). [Default: frogsfunc_functions_weighted_nsti.tsv]"
    outputBinding:
      glob: '${ return inputs.output_weighted_nsti_path ? inputs.output_weighted_nsti_path : ''frogsfunc_functions_weighted_nsti.tsv''; }'
  - id: output_biom
    type: ['null', File]
    doc: "Biom file of kept ASVs (NSTI, blast perc identity or blast perc coverage thresholds). (format: BIOM) [Default: frogsfunc_function_asv_abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''frogsfunc_function_asv_abundance.biom''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "Fasta file of kept ASVs (NSTI, blast perc identity or blast perc coverage thresholds). (format: FASTA). [Default: frogsfunc_function_asv.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''frogsfunc_function_asv.fasta''; }'
  - id: output_excluded
    type: ['null', File]
    doc: "List of ASVs with NSTI values above NSTI threshold ( --max_NSTI NSTI ).[Default: frogsfunc_functions_asv_excluded.txt]"
    outputBinding:
      glob: '${ return inputs.output_excluded_path ? inputs.output_excluded_path : ''frogsfunc_functions_asv_excluded.txt''; }'
  - id: log_file
    type: ['null', File]
    doc: "List of commands executed. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''frogsfunc_functions_stdout.txt''; }'
  - id: html
    type: ['null', File]
    doc: "Path to store resulting html file. [Default: frogsfunc_functions_summary.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''frogsfunc_functions_summary.html''; }'
  - id: copynumbers_predicted
    type: ['null', {type: array, items: File}]
    doc: Predicted function copy numbers per ASV (for example EC_copynumbers_predicted.tsv).
    outputBinding:
      glob: '*_copynumbers_predicted.tsv'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: frogsfunc_functions_stdout.txt
