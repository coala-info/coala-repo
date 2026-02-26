cwlVersion: v1.2
class: CommandLineTool
baseCommand: picrust2_pipeline.py
label: picrust2_picrust2_pipeline.py
doc: "Wrapper for full PICRUSt2 pipeline to be run with two different domains. This
  is intended for use with the new separate bacteria and archaea trees and reference
  trait tables. Run sequence placement with EPA-NG and GAPPA to place study sequences
  (i.e. OTUs and ASVs) into a reference tree. Then runs hidden-state prediction with
  the castor R package to predict NSTI and marker gene copy number for each study
  sequence. The domain that best fits each study sequence will then be chosen and
  hidden-state prediction with the castor R package will be used to predict traits
  for each genome. Predicted traits for all genomes are combined for both domains
  Metagenome profiles are then generated, which can be optionally stratified by the
  contributing sequence. Finally, pathway abundances are predicted based on metagenome
  profiles. By default, output files include predictions for Enzyme Commission (EC)
  numbers, KEGG Orthologs (KOs), and MetaCyc pathway abundances. However, this script
  enables users to use custom reference and trait tables to customize analyses. If
  you wish to run the previous version of PICRUSt2 (i.e. a single reference for all
  prokaryotes, please use the picrust2_pipeline.py script. This version was designed
  for running the separate bacterial and archaeal trees, but could be used for any
  two domains. If you know that your study sequences only contain bacteria, or only
  contain archaea, you may wish to run the picrust2_pipeline.py script but specifying
  bacteria/archaea as the reference database to use.\n\nTool homepage: https://github.com/picrust/picrust2"
inputs:
  - id: coverage
    type:
      - 'null'
      - boolean
    doc: Calculate pathway coverages as well as abundances, which are 
      experimental and only useful for advanced users.
    inputBinding:
      position: 101
      prefix: --coverage
  - id: custom_trait_tables_ref1
    type:
      - 'null'
      - File
    doc: Optional path to custom trait tables for domain 1 with gene families as
      columns and genomes as rows (overrides --in_traits setting) to be used for
      hidden-state prediction. Multiple tables can be specified by delimiting 
      filenames by commas. Importantly, the first custom table specified will be
      used for inferring pathway abundances. Typically this command would be 
      used with a custom marker gene table (--marker_gene_table) as well.
    inputBinding:
      position: 101
      prefix: --custom_trait_tables_ref1
  - id: custom_trait_tables_ref2
    type:
      - 'null'
      - File
    doc: Optional path to custom trait tables for domain 2 with gene families as
      columns and genomes as rows (overrides --in_traits setting) to be used for
      hidden-state prediction. Multiple tables can be specified by delimiting 
      filenames by commas. Importantly, the first custom table specified will be
      used for inferring pathway abundances. Typically this command would be 
      used with a custom marker gene table (--marker_gene_table) as well.
    inputBinding:
      position: 101
      prefix: --custom_trait_tables_ref2
  - id: edge_exponent
    type:
      - 'null'
      - float
    doc: 'Setting for maximum parisomony hidden-state prediction. Specifies weighting
      transition costs by the inverse length of edge lengths. If 0, then edge lengths
      do not influence predictions. Must be a non-negative real-valued number (default:
      0.500000).'
    default: 0.5
    inputBinding:
      position: 101
      prefix: --edge_exponent
  - id: hsp_method
    type:
      - 'null'
      - string
    doc: 'HSP method to use."mp": predict discrete traits using max parsimony. "emp_prob":
      predict discrete traits based on empirical state probabilities across tips.
      "subtree_average": predict continuous traits using subtree averaging. "pic":
      predict continuous traits with phylogentic independent contrast. "scp": reconstruct
      continuous traits using squared-change parsimony (default: mp).'
    default: mp
    inputBinding:
      position: 101
      prefix: --hsp_method
  - id: in_traits
    type:
      - 'null'
      - string
    doc: 'Comma-delimited list (with no spaces) of which gene families to predict
      from this set: EC, KO, GO, PFAM, BIGG, CAZY, GENE_NAMES. Note that EC numbers
      will always be predicted unless --no_pathways is set (default: EC,KO).'
    default: EC,KO
    inputBinding:
      position: 101
      prefix: --in_traits
  - id: input
    type: File
    doc: Input table of sequence abundances (BIOM, TSV or mothur shared file 
      format).
    inputBinding:
      position: 101
      prefix: --input
  - id: marker_gene_table_ref1
    type:
      - 'null'
      - File
    doc: Path to marker gene copy number table for domain 2 (16S copy numbers 
      for bacteria by default).
    inputBinding:
      position: 101
      prefix: --marker_gene_table_ref1
  - id: marker_gene_table_ref2
    type:
      - 'null'
      - File
    doc: Path to marker gene copy number table for domain 2 (16S copy numbers 
      for archaea by default).
    inputBinding:
      position: 101
      prefix: --marker_gene_table_ref2
  - id: max_nsti
    type:
      - 'null'
      - float
    doc: 'Sequences with NSTI values above this value will be excluded (default: 2).'
    default: 2.0
    inputBinding:
      position: 101
      prefix: --max_nsti
  - id: min_align
    type:
      - 'null'
      - float
    doc: 'Proportion of the total length of an input query sequence that must align
      with reference sequences. Any sequences with lengths below this value after
      making an alignment with reference sequences will be excluded from the placement
      and all subsequent steps. (default: 0).'
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min_align
  - id: min_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of reads across all samples for each input ASV. ASVs below
      this cut-off will be counted as part of the "RARE" category in the stratified
      output (default: 1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --min_reads
  - id: min_samples
    type:
      - 'null'
      - int
    doc: 'Minimum number of samples that an ASV needs to be identfied within. ASVs
      below this cut-off will be counted as part of the "RARE" category in the stratified
      output (default: 1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --min_samples
  - id: no_gap_fill
    type:
      - 'null'
      - boolean
    doc: Do not perform gap filling before predicting pathway abundances (Gap 
      filling is on otherwise by default.
    inputBinding:
      position: 101
      prefix: --no_gap_fill
  - id: no_pathways
    type:
      - 'null'
      - boolean
    doc: Flag to indicate that pathways should NOT be inferred (otherwise they 
      will be inferred by default). Predicted EC number abundances are used to 
      infer pathways when the default reference files are used.
    inputBinding:
      position: 101
      prefix: --no_pathways
  - id: no_regroup
    type:
      - 'null'
      - boolean
    doc: Do not regroup input gene families to reactions as specified in the 
      regrouping mapfile. This option should only be used if you are using 
      custom reference and/or mapping files.
    inputBinding:
      position: 101
      prefix: --no_regroup
  - id: pathway_map
    type:
      - 'null'
      - File
    doc: 'MinPath mapfile. The default mapfile maps MetaCyc reactions to prokaryotic
      pathways (default: /usr/local/lib/python3.12/site-packages/picrust2/default_files/pathway_mapfiles/metacyc_pathways_structured_filtered_v24.txt).'
    default: 
      /usr/local/lib/python3.12/site-packages/picrust2/default_files/pathway_mapfiles/metacyc_pathways_structured_filtered_v24.txt
    inputBinding:
      position: 101
      prefix: --pathway_map
  - id: per_sequence_contrib
    type:
      - 'null'
      - boolean
    doc: 'Flag to specify that MinPath is run on the genes contributed by each sequence
      (i.e. a predicted genome) individually. Note this will greatly increase the
      runtime. The output will be the predicted pathway abundance contributed by each
      individual sequence. This is in contrast to the default stratified output, which
      is the contribution to the community-wide pathway abundances. Pathway coverage
      stratified by contributing sequence will also be output when --coverage is set
      (default: False).'
    inputBinding:
      position: 101
      prefix: --per_sequence_contrib
  - id: placement_tool
    type:
      - 'null'
      - string
    doc: 'Placement tool to use when placing sequences into reference tree. One of
      "epa-ng" or "sepp" must be input (default: epa-ng)'
    default: epa-ng
    inputBinding:
      position: 101
      prefix: --placement_tool
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to run in parallel (default: 1).'
    default: 1
    inputBinding:
      position: 101
      prefix: --processes
  - id: reaction_func
    type:
      - 'null'
      - string
    doc: 'Functional database to use as reactions for inferring pathway abundances
      (default: EC). This should be either the short-form of the database as specified
      in --in_traits, or the path to the file as would be specified for --custom_trait_tables.
      Note that when functions besides the default EC numbers are used typically the
      --no_regroup option would also be set.'
    default: EC
    inputBinding:
      position: 101
      prefix: --reaction_func
  - id: ref_dir1
    type:
      - 'null'
      - Directory
    doc: 'Directory containing reference sequence files (default: /usr/local/lib/python3.12/site-packages/picrust2/default_files/bacteria/bac_ref).
      Please see the online documentation for how to name the files in this directory.'
    default: 
      /usr/local/lib/python3.12/site-packages/picrust2/default_files/bacteria/bac_ref
    inputBinding:
      position: 101
      prefix: --ref_dir1
  - id: ref_dir2
    type:
      - 'null'
      - Directory
    doc: 'Directory containing reference sequence files (default: /usr/local/lib/python3.12/site-packages/picrust2/default_files/archaea/arc_ref).
      Please see the online documentation for how to name the files in this directory.'
    default: 
      /usr/local/lib/python3.12/site-packages/picrust2/default_files/archaea/arc_ref
    inputBinding:
      position: 101
      prefix: --ref_dir2
  - id: regroup_map
    type:
      - 'null'
      - File
    doc: 'Mapfile of ids to regroup gene families to before running MinPath. The default
      mapfile is for regrouping EC numbers to MetaCyc reactions (default: /usr/local/lib/python3.12/site-packages/picrust2/default_files/pathway_mapfiles/ec_level4_to_metacyc_rxn_new.tsv).'
    default: 
      /usr/local/lib/python3.12/site-packages/picrust2/default_files/pathway_mapfiles/ec_level4_to_metacyc_rxn_new.tsv
    inputBinding:
      position: 101
      prefix: --regroup_map
  - id: remove_intermediate
    type:
      - 'null'
      - boolean
    doc: Remove the intermediate outfiles of the sequence placement and pathway 
      inference steps.
    inputBinding:
      position: 101
      prefix: --remove_intermediate
  - id: skip_minpath
    type:
      - 'null'
      - boolean
    doc: Do not run MinPath to identify which pathways are present as a first 
      pass (on by default).
    inputBinding:
      position: 101
      prefix: --skip_minpath
  - id: skip_norm
    type:
      - 'null'
      - boolean
    doc: Skip normalizing sequence abundances by predicted marker gene copy 
      numbers (typically 16S rRNA genes). This step will be performed 
      automatically unless this option is specified.
    inputBinding:
      position: 101
      prefix: --skip_norm
  - id: stratified
    type:
      - 'null'
      - boolean
    doc: Flag to indicate that stratified tables should be generated at all 
      steps (will increase run-time).
    inputBinding:
      position: 101
      prefix: --stratified
  - id: study_fasta
    type: File
    doc: FASTA of unaligned study sequences (e.g. ASVs). The headerline should 
      be only one field (i.e. no additional whitespace-delimited fields).
    inputBinding:
      position: 101
      prefix: --study_fasta
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out details as commands are run.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: wide_table
    type:
      - 'null'
      - boolean
    doc: Output wide-format stratified table of metagenome and pathway 
      predictions when "--stratified" is set. This is the deprecated method of 
      generating stratified tables since it is extremely memory intensive. The 
      stratified filenames contain "strat" rather than "contrib" when this 
      option is used.
    inputBinding:
      position: 101
      prefix: --wide_table
outputs:
  - id: output
    type: Directory
    doc: Output folder for final files.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
