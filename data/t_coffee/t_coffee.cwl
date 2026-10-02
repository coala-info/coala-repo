cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - t_coffee
label: t_coffee
doc: T-COFFEE multiple sequence alignment package
inputs:
  - id: no_error_report
    type:
      - 'null'
      - int
    doc: 'Limit the maximum memory usage (in Megabytes). 0: no limit'
    inputBinding:
      position: 101
      prefix: -no_error_report
  - id: parameters
    type:
      - 'null'
      - File
    doc: get bottom parameters
    inputBinding:
      position: 101
      prefix: -parameters
  - id: mode
    type:
      - 'null'
      - type: array
        items: string
    doc: 'specifies a special mode: genome, quickaln, dali, 3dcoffee'
    inputBinding:
      position: 101
      prefix: -mode
  - id: special_mode
    type:
      - 'null'
      - type: array
        items: string
    doc: '[DEPRECATED ** -special_mode is deprected use -mode instead]'
    inputBinding:
      position: 101
      prefix: -special_mode
  - id: t_coffee_defaults
    type:
      - 'null'
      - File
    doc: get top parameters
    inputBinding:
      position: 101
      prefix: -t_coffee_defaults
  - id: type_only
    type:
      - 'null'
      - boolean
    doc: exit after checking the type and returning it to the stdout
    inputBinding:
      position: 101
      prefix: -type_only
  - id: check_type
    type:
      - 'null'
      - boolean
    doc: Make sure that -type and the real type of the sequences agree
    inputBinding:
      position: 101
      prefix: -check_type
  - id: type
    type:
      - 'null'
      - string
    doc: PROTEIN, DNA or RNA. Automatically set, but can be forced with this 
      flag
    inputBinding:
      position: 101
      prefix: -type
  - id: dpa
    type:
      - 'null'
      - int
    doc: Run DPA mode
    inputBinding:
      position: 101
      prefix: -dpa
  - id: reg
    type:
      - 'null'
      - int
    doc: Run DPA mode
    inputBinding:
      position: 101
      prefix: -reg
  - id: plugins
    type:
      - 'null'
      - Directory
    doc: Set the directory containing the plugins [no if no plugin]
    inputBinding:
      position: 101
      prefix: -plugins
  - id: plugins_order
    type:
      - 'null'
      - string
    doc: first or last. Set the order of the plugins for T-Coffee. First means 
      the plugins are used first. Last means that local installations are used 
      first and the plugins only used if the local installation cannot
    inputBinding:
      position: 101
      prefix: -plugins_order
  - id: score
    type:
      - 'null'
      - boolean
    doc: 'DEPRECATED: use -special_mode evaluate instead'
    inputBinding:
      position: 101
      prefix: -score
  - id: evaluate
    type:
      - 'null'
      - boolean
    doc: Use -special_mode evaluate for a default behavior
    inputBinding:
      position: 101
      prefix: -evaluate
  - id: genepred
    type:
      - 'null'
      - boolean
    doc: Use -special_mode genepred for a default behavior
    inputBinding:
      position: 101
      prefix: -genepred
  - id: convert
    type:
      - 'null'
      - boolean
    doc: forces the program to make a conversion
    inputBinding:
      position: 101
      prefix: -convert
  - id: quiet
    type:
      - 'null'
      - string
    doc: Defines the file in which the log output is written
    inputBinding:
      position: 101
      prefix: -quiet
  - id: debug
    type:
      - 'null'
      - int
    doc: '0 [default]: no dump; 1: dump the input, 2: dump input and keep tmp files'
    inputBinding:
      position: 101
      prefix: -debug
  - id: clean
    type:
      - 'null'
      - string
    doc: 'Will delete cached data and exit: all, cache, lock, tmp. It is possible
      to specify a list: cache_lock_tmp'
    inputBinding:
      position: 101
      prefix: -clean
  - id: check_configuration
    type:
      - 'null'
      - boolean
    doc: checks that the required programs are installed
    inputBinding:
      position: 101
      prefix: -check_configuration
  - id: update
    type:
      - 'null'
      - boolean
    doc: checks the existence of an updated version
    inputBinding:
      position: 101
      prefix: -update
  - id: full_log
    type:
      - 'null'
      - string
    doc: Sets the prefix of all the output files
    inputBinding:
      position: 101
      prefix: -full_log
  - id: genepred_score
    type:
      - 'null'
      - string
    doc: nsd,tot, <seq_name>
    inputBinding:
      position: 101
      prefix: -genepred_score
  - id: run_name
    type:
      - 'null'
      - string
    doc: Sets the prefix of all the output files
    inputBinding:
      position: 101
      prefix: -run_name
  - id: mem_mode
    type:
      - 'null'
      - string
    doc: Deprecated
    inputBinding:
      position: 101
      prefix: -mem_mode
  - id: extend
    type:
      - 'null'
      - int
    doc: Do Library Extention On the Fly
    inputBinding:
      position: 101
      prefix: -extend
  - id: extend_mode
    type:
      - 'null'
      - string
    doc: Library extension mode
    inputBinding:
      position: 101
      prefix: -extend_mode
  - id: max_n_pair
    type:
      - 'null'
      - int
    doc: Indicates the Number of Pairs to Compare when making prf Vs prf. 
      0<=>every pair
    inputBinding:
      position: 101
      prefix: -max_n_pair
  - id: seq_name_for_quadruplet
    type:
      - 'null'
      - type: array
        items: string
    doc: Indicates which sequence must be used to compute quadruplets
    inputBinding:
      position: 101
      prefix: -seq_name_for_quadruplet
  - id: compact
    type:
      - 'null'
      - string
    doc: Deprecated
    inputBinding:
      position: 101
      prefix: -compact
  - id: do_self
    type:
      - 'null'
      - boolean
    doc: Make self extension. Used by Mocca
    inputBinding:
      position: 101
      prefix: -do_self
  - id: do_normalise
    type:
      - 'null'
      - int
    doc: Normalisation factor when computing scores
    inputBinding:
      position: 101
      prefix: -do_normalise
  - id: template_file
    type:
      - 'null'
      - type: array
        items: string
    doc: List of templates file for the sequences
    inputBinding:
      position: 101
      prefix: -template_file
  - id: template_dir_e
    type:
      - 'null'
      - type: array
        items: string
    doc: directory for _E_ templates (_R_ <dir> _P_ <dir>...
    inputBinding:
      position: 101
      prefix: -template_dir_E_
  - id: setenv
    type:
      - 'null'
      - type: array
        items: string
    doc: Declares a parameter variable
    inputBinding:
      position: 101
      prefix: -setenv
  - id: export
    type:
      - 'null'
      - type: array
        items: string
    doc: Declares a parameter variable
    inputBinding:
      position: 101
      prefix: -export
  - id: template_mode
    type:
      - 'null'
      - type: array
        items: string
    doc: List of template procedures
    inputBinding:
      position: 101
      prefix: -template_mode
  - id: flip
    type:
      - 'null'
      - int
    doc: flip sequences
    inputBinding:
      position: 101
      prefix: -flip
  - id: remove_template_file
    type:
      - 'null'
      - int
    doc: 'Remove all the template files: 0 keep all, 1: only remove the template files
      2: remove template files AND template lists'
    inputBinding:
      position: 101
      prefix: -remove_template_file
  - id: profile_template_file
    type:
      - 'null'
      - type: array
        items: string
    doc: List of templates files asscoaciated with profiles
    inputBinding:
      position: 101
      prefix: -profile_template_file
  - id: in
    type:
      - 'null'
      - type: array
        items: string
    doc: Reads the Ssequences, Mmethods, 
      Llibraries,Xmatrices,Rprofiles,Pstructures,AAlignments
    inputBinding:
      position: 101
      prefix: -in
  - id: seq
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sequences in any acceptable format
    inputBinding:
      position: 101
      prefix: -seq
  - id: aln
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sequences in any acceptable format
    inputBinding:
      position: 101
      prefix: -aln
  - id: method_limits
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of limits for selected methods: method maxnseq maxlen (-1 = nolimit)'
    inputBinding:
      position: 101
      prefix: -method_limits
  - id: method
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sequences in any acceptable format
    inputBinding:
      position: 101
      prefix: -method
  - id: lib
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sequences in any acceptable format
    inputBinding:
      position: 101
      prefix: -lib
  - id: profile
    type:
      - 'null'
      - type: array
        items: string
    doc: Input one or many MSA that will be treated as profiles
    inputBinding:
      position: 101
      prefix: -profile
  - id: profile1
    type:
      - 'null'
      - string
    doc: Input one profile (ClustalW option)
    inputBinding:
      position: 101
      prefix: -profile1
  - id: profile2
    type:
      - 'null'
      - string
    doc: Input a profile (ClustalW option)
    inputBinding:
      position: 101
      prefix: -profile2
  - id: pdb
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Reads/fetch a pdb file: PDBID(PDB_CHAIN)[opt] (FIRST,LAST)[opt],'
    inputBinding:
      position: 101
      prefix: -pdb
  - id: relax_lib
    type:
      - 'null'
      - int
    doc: self extend the library, without adding new positions
    inputBinding:
      position: 101
      prefix: -relax_lib
  - id: filter_lib
    type:
      - 'null'
      - int
    doc: Removes from the library every value below the threshold
    inputBinding:
      position: 101
      prefix: -filter_lib
  - id: shrink_lib
    type:
      - 'null'
      - int
    doc: Runks linked_pairwise on the lib to remove every useless diagonal
    inputBinding:
      position: 101
      prefix: -shrink_lib
  - id: out_lib
    type:
      - 'null'
      - string
    doc: Prompts the program to write the computed library file
    inputBinding:
      position: 101
      prefix: -out_lib
  - id: out_lib_mode
    type:
      - 'null'
      - string
    doc: Save the primary or the extended 
      library:[primary|extende]extended_[pair|lib]_[raw|pc]
    inputBinding:
      position: 101
      prefix: -out_lib_mode
  - id: lib_only
    type:
      - 'null'
      - int
    doc: Only Compute the library
    inputBinding:
      position: 101
      prefix: -lib_only
  - id: outseqweight
    type:
      - 'null'
      - string
    doc: Prompts the program to write the sequuence weight values
    inputBinding:
      position: 101
      prefix: -outseqweight
  - id: seq_source
    type:
      - 'null'
      - string
    doc: Indicates the files that will be used as sequence sources, important 
      for dpa. With the default mode alignments must be provided with the Sflag 
      as well as tye Aflag if they contribute novel sequences
    inputBinding:
      position: 101
      prefix: -seq_source
  - id: cosmetic_penalty
    type:
      - 'null'
      - int
    doc: A very low Gap Opening Penalty.It only affects the non stable portions 
      of the alignmnent.Negative values penalize gaps, positive values reward 
      them
    inputBinding:
      position: 101
      prefix: -cosmetic_penalty
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Gap opening penalty. Must be negative, best matches get a score of 1000
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: gapext
    type:
      - 'null'
      - int
    doc: Gap Extension Penalty. Positive values give rewards to gaps and prevent
      the alignment of unrelated segments
    inputBinding:
      position: 101
      prefix: -gapext
  - id: fgapopen
    type:
      - 'null'
      - int
    doc: Deprecated
    inputBinding:
      position: 101
      prefix: -fgapopen
  - id: fgapext
    type:
      - 'null'
      - int
    doc: Deprecated
    inputBinding:
      position: 101
      prefix: -fgapext
  - id: nomatch
    type:
      - 'null'
      - int
    doc: Deprecated
    inputBinding:
      position: 101
      prefix: -nomatch
  - id: newtree
    type:
      - 'null'
      - string
    doc: Name of the output guide tree
    inputBinding:
      position: 101
      prefix: -newtree
  - id: tree
    type:
      - 'null'
      - string
    doc: Name of the output guide tree
    inputBinding:
      position: 101
      prefix: -tree
  - id: usetree
    type:
      - 'null'
      - File
    doc: Use an existing guide tree
    inputBinding:
      position: 101
      prefix: -usetree
  - id: tree_mode
    type:
      - 'null'
      - string
    doc: nj, upgma, cwph,kmeans
    inputBinding:
      position: 101
      prefix: -tree_mode
  - id: distance_matrix_mode
    type:
      - 'null'
      - string
    doc: 'Computation of the distances for the tree: slow, fast, very_fast, ktup'
    inputBinding:
      position: 101
      prefix: -distance_matrix_mode
  - id: distance_matrix_sim_mode
    type:
      - 'null'
      - string
    doc: 'Choice of the distance measure: <mat>_sim1, _sim2, _sim3, _cov, _gap'
    inputBinding:
      position: 101
      prefix: -distance_matrix_sim_mode
  - id: quicktree
    type:
      - 'null'
      - boolean
    doc: Use distance_matrix_mode=very_fast
    inputBinding:
      position: 101
      prefix: -quicktree
  - id: outfile
    type:
      - 'null'
      - string
    doc: Name of the output alignment
    inputBinding:
      position: 101
      prefix: -outfile
  - id: maximise
    type:
      - 'null'
      - boolean
    doc: Deprecated
    inputBinding:
      position: 101
      prefix: -maximise
  - id: output
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Specifies one or many formats that must be output: clustalw_aln, msf_aln,
      tcs_[residue,column]_[filter,lower][0-9], tcs_[weighted,replicate][Nreplicates],sp_ascii,
      score_ascii . The file extension is the output format'
    inputBinding:
      position: 101
      prefix: -output
  - id: len
    type:
      - 'null'
      - int
    doc: Line Length
    inputBinding:
      position: 101
      prefix: -len
  - id: infile
    type:
      - 'null'
      - File
    doc: input a pre-computed alignment, or a file to reformat
    inputBinding:
      position: 101
      prefix: -infile
  - id: matrix
    type:
      - 'null'
      - string
    doc: Specifies the substitution matrix.
    inputBinding:
      position: 101
      prefix: -matrix
  - id: fs_matrix
    type:
      - 'null'
      - string
    doc: Specifies the substitution matrix used on 3di.
    inputBinding:
      position: 101
      prefix: -fs_matrix
  - id: fs_gop
    type:
      - 'null'
      - int
    doc: Must Be Negative
    inputBinding:
      position: 101
      prefix: -fs_gop
  - id: fs_gep
    type:
      - 'null'
      - int
    doc: Must Be Negative
    inputBinding:
      position: 101
      prefix: -fs_gep
  - id: tg_mode
    type:
      - 'null'
      - int
    doc: "0: Penalise Term gap with gapopen and gapext\n1: gapopen only\n2: No penalty"
    inputBinding:
      position: 101
      prefix: -tg_mode
  - id: profile_mode
    type:
      - 'null'
      - string
    doc: Function used to compute profile2profile scores
    inputBinding:
      position: 101
      prefix: -profile_mode
  - id: profile_comparison
    type:
      - 'null'
      - string
    doc: 'Method used to compare two profiles: full<N>: compares <every | N best>
      pair of sequence and every pair of structure if a structure method is used,profile:
      compares only the profiles.'
    inputBinding:
      position: 101
      prefix: -profile_comparison
  - id: dp_mode
    type:
      - 'null'
      - string
    doc: 'Type of alignment algorithm used by T-Coffee: gotoh_pair_wise, myers_millers_pair_wise,'
    inputBinding:
      position: 101
      prefix: -dp_mode
  - id: ktuple
    type:
      - 'null'
      - int
    doc: Word size when using the heursitic dynamic programming modes 
      fasta_pair_wise and cfasta_pair_wise
    inputBinding:
      position: 101
      prefix: -ktuple
  - id: ndiag
    type:
      - 'null'
      - int
    doc: Number of diagonals to consider when using the heursitic dynamic 
      programming modes fasta_pair_wise and cfasta_pair_wise
    inputBinding:
      position: 101
      prefix: -ndiag
  - id: diag_threshold
    type:
      - 'null'
      - int
    doc: ND
    inputBinding:
      position: 101
      prefix: -diag_threshold
  - id: diag_mode
    type:
      - 'null'
      - int
    doc: "0: Use the whole Diag\n1: Use the best match"
    inputBinding:
      position: 101
      prefix: -diag_mode
  - id: sim_matrix
    type:
      - 'null'
      - string
    doc: Degenerated matrix used to compute a similarity
    inputBinding:
      position: 101
      prefix: -sim_matrix
  - id: transform
    type:
      - 'null'
      - string
    doc: dna2rna, rna2dna, dna2prot
    inputBinding:
      position: 101
      prefix: -transform
  - id: extend_seq
    type:
      - 'null'
      - boolean
    doc: extend the sequences
    inputBinding:
      position: 101
      prefix: -extend_seq
  - id: outorder
    type:
      - 'null'
      - string
    doc: 'Specifies the order of the sequences in the msa: input or aligned'
    inputBinding:
      position: 101
      prefix: -outorder
  - id: inorder
    type:
      - 'null'
      - string
    doc: 'aligned: sort the sequences in alphabetic order before starting thus making
      the input order irrelevant but delivering a library in arbitratry order, keep:
      input order is used in the library but results become input order dependant'
    inputBinding:
      position: 101
      prefix: -inorder
  - id: seqnos
    type:
      - 'null'
      - string
    doc: Adds Residue Numbers to the MSA
    inputBinding:
      position: 101
      prefix: -seqnos
  - id: case
    type:
      - 'null'
      - string
    doc: 'Causes the case to be: kept:lower:upper.'
    inputBinding:
      position: 101
      prefix: -case
  - id: cpu
    type:
      - 'null'
      - int
    doc: Makes it possible to add a pre-specified amount of cpu time to the 
      measured usage
    inputBinding:
      position: 101
      prefix: -cpu
  - id: ulimit
    type:
      - 'null'
      - int
    doc: Maximum amount of memory to be used. Kill job otherwise
    inputBinding:
      position: 101
      prefix: -ulimit
  - id: maxnseq
    type:
      - 'null'
      - int
    doc: Maximum number of sequences (-1=no max)
    inputBinding:
      position: 101
      prefix: -maxnseq
  - id: maxlen
    type:
      - 'null'
      - int
    doc: Maximum length of a sequence (-1=no max)
    inputBinding:
      position: 101
      prefix: -maxlen
  - id: sample_dp
    type:
      - 'null'
      - int
    doc: defines the tie breaking strategy (only with gotoh_pair_wise)
    inputBinding:
      position: 101
      prefix: -sample_dp
  - id: weight
    type:
      - 'null'
      - string
    doc: 'Defines the library weight: sim OR  sim_(matrix) OR winsim'
    inputBinding:
      position: 101
      prefix: -weight
  - id: seq_weight
    type:
      - 'null'
      - string
    doc: Defines the sequences weighting scheme t_coffee
    inputBinding:
      position: 101
      prefix: -seq_weight
  - id: align
    type:
      - 'null'
      - boolean
    doc: forces the program to make the alignment
    inputBinding:
      position: 101
      prefix: -align
  - id: mocca
    type:
      - 'null'
      - boolean
    doc: forces the program to extract domains
    inputBinding:
      position: 101
      prefix: -mocca
  - id: domain
    type:
      - 'null'
      - boolean
    doc: forces the program to extract domains
    inputBinding:
      position: 101
      prefix: -domain
  - id: start
    type:
      - 'null'
      - int
    doc: start of the master domain in the mocca mode
    inputBinding:
      position: 101
      prefix: -start
  - id: scale
    type:
      - 'null'
      - int
    doc: Decreases the t_coffee score by Scale, so that non match get negative 
      values
    inputBinding:
      position: 101
      prefix: -scale
  - id: mocca_interactive
    type:
      - 'null'
      - boolean
    doc: Runs Mocca in an interactive manneer
    inputBinding:
      position: 101
      prefix: -mocca_interactive
  - id: method_evaluate_mode
    type:
      - 'null'
      - string
    doc: Specifies which method should be used to evaluate the score at the 
      pairwise level
    inputBinding:
      position: 101
      prefix: -method_evaluate_mode
  - id: color_mode
    type:
      - 'null'
      - string
    doc: Mode used to produce the color output:new (default) or old
    inputBinding:
      position: 101
      prefix: -color_mode
  - id: aln_line_length
    type:
      - 'null'
      - int
    doc: Mode used to produce the color output:t_coffee_fast,t_coffee_slow
    inputBinding:
      position: 101
      prefix: -aln_line_length
  - id: evaluate_mode
    type:
      - 'null'
      - string
    doc: Mode used to produce the color output:t_coffee_fast,t_coffee_slow
    inputBinding:
      position: 101
      prefix: -evaluate_mode
  - id: get_type
    type:
      - 'null'
      - boolean
    doc: forces t_coffee top get the type of the sequences
    inputBinding:
      position: 101
      prefix: -get_type
  - id: clean_aln
    type:
      - 'null'
      - int
    doc: Forces weak portion of aln to be realigned
    inputBinding:
      position: 101
      prefix: -clean_aln
  - id: clean_threshold
    type:
      - 'null'
      - int
    doc: Threshold for the portions of the MSA that will are realigned by 
      '-clean_evaluate_mode'. The threshold refers to the CORE score set by 
      '-evaluate_mode'
    inputBinding:
      position: 101
      prefix: -clean_threshold
  - id: clean_iteration
    type:
      - 'null'
      - int
    doc: Number of rounds for '-clean_aln'
    inputBinding:
      position: 101
      prefix: -clean_iteration
  - id: clean_evaluate_mode
    type:
      - 'null'
      - string
    doc: Mode used to score residues (see evaluate_mode)
    inputBinding:
      position: 101
      prefix: -clean_evaluate_mode
  - id: extend_matrix
    type:
      - 'null'
      - boolean
    doc: Deprecated
    inputBinding:
      position: 101
      prefix: -extend_matrix
  - id: prot_min_sim
    type:
      - 'null'
      - int
    doc: Minimum similarity between a sequence and its BLAST relatives
    inputBinding:
      position: 101
      prefix: -prot_min_sim
  - id: prot_max_sim
    type:
      - 'null'
      - int
    doc: Maximum similarity between a sequence and its BLAST relatives
    inputBinding:
      position: 101
      prefix: -prot_max_sim
  - id: psi_j
    type:
      - 'null'
      - int
    doc: Defines the number of iteration of psiblast (-j)
    inputBinding:
      position: 101
      prefix: -psiJ
  - id: psitrim_mode
    type:
      - 'null'
      - string
    doc: Mode used to trim profiles, regtrim or trim (def)
    inputBinding:
      position: 101
      prefix: -psitrim_mode
  - id: psitrim_tree
    type:
      - 'null'
      - string
    doc: Mode used to compute the tree when using regtree to trim profiles 
      (codnd def)
    inputBinding:
      position: 101
      prefix: -psitrim_tree
  - id: psitrim
    type:
      - 'null'
      - int
    doc: Maximum number of sequences to keep when building a profile [0 to keep 
      everything, negative value to keep X%, positive value to keep X Sequences]
    inputBinding:
      position: 101
      prefix: -psitrim
  - id: prot_min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage of a sequence by its BLAST relatives
    inputBinding:
      position: 101
      prefix: -prot_min_cov
  - id: pdb_type
    type:
      - 'null'
      - string
    doc: 'd: diffraction, n: nmr, e: em, m:model'
    inputBinding:
      position: 101
      prefix: -pdb_type
  - id: pdb_min_sim
    type:
      - 'null'
      - int
    doc: Minimum similarity between a sequence and its PDB target
    inputBinding:
      position: 101
      prefix: -pdb_min_sim
  - id: pdb_max_sim
    type:
      - 'null'
      - int
    doc: Maximum similarity between a sequence and its PDB target
    inputBinding:
      position: 101
      prefix: -pdb_max_sim
  - id: pdb_min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage of a sequence by its PDB target
    inputBinding:
      position: 101
      prefix: -pdb_min_cov
  - id: pdb_blast_server
    type:
      - 'null'
      - string
    doc: ND
    inputBinding:
      position: 101
      prefix: -pdb_blast_server
  - id: blast
    type:
      - 'null'
      - string
    doc: ND
    inputBinding:
      position: 101
      prefix: -blast
  - id: blast_server
    type:
      - 'null'
      - string
    doc: ND
    inputBinding:
      position: 101
      prefix: -blast_server
  - id: pdb_db
    type:
      - 'null'
      - string
    doc: Non Redundant PDB database
    inputBinding:
      position: 101
      prefix: -pdb_db
  - id: protein_db
    type:
      - 'null'
      - string
    doc: ND
    inputBinding:
      position: 101
      prefix: -protein_db
  - id: method_log
    type:
      - 'null'
      - string
    doc: ND
    inputBinding:
      position: 101
      prefix: -method_log
  - id: struc_to_use
    type:
      - 'null'
      - type: array
        items: string
    doc: Specifies the structures that must be used when combining sequences and
      structures. The default is to use all the structures.
    inputBinding:
      position: 101
      prefix: -struc_to_use
  - id: cache
    type:
      - 'null'
      - string
    doc: 'Specifies that a cache must be used to save the structures and their comparison,
      as well as the blast searches. available modes are: use,ignore,update,local,
      directory name'
    inputBinding:
      position: 101
      prefix: -cache
  - id: print_cache
    type:
      - 'null'
      - boolean
    doc: print the cache dir to stdout and exit
    inputBinding:
      position: 101
      prefix: -print_cache
  - id: align_pdb_param_file
    type:
      - 'null'
      - File
    doc: parameter_file
    inputBinding:
      position: 101
      prefix: -align_pdb_param_file
  - id: align_pdb_hasch_mode
    type:
      - 'null'
      - string
    doc: parameter_file
    inputBinding:
      position: 101
      prefix: -align_pdb_hasch_mode
  - id: external_aligner
    type:
      - 'null'
      - string
    doc: Use seqan to compute the MSA
    inputBinding:
      position: 101
      prefix: -external_aligner
  - id: msa_mode
    type:
      - 'null'
      - string
    doc: 'Algorithm used to compute the MSA: tree | graph'
    inputBinding:
      position: 101
      prefix: -msa_mode
  - id: et_mode
    type:
      - 'null'
      - string
    doc: 'Algorithm used to the et score: id, et, sankoff, sp'
    inputBinding:
      position: 101
      prefix: -et_mode
  - id: master
    type:
      - 'null'
      - string
    doc: 'Align all the sequences to the master sequences: file or number'
    inputBinding:
      position: 101
      prefix: -master
  - id: blast_nseq
    type:
      - 'null'
      - int
    doc: 'Maximum number of querries for BLAST (0: all)'
    inputBinding:
      position: 101
      prefix: -blast_nseq
  - id: lalign_n_top
    type:
      - 'null'
      - int
    doc: Number of local alignments reported by the local method (lalign) when 
      building the library
    inputBinding:
      position: 101
      prefix: -lalign_n_top
  - id: iterate
    type:
      - 'null'
      - int
    doc: 'NUmber of iteration on the progressive alignment [0: no iteration, -1: Nseq
      iterations]'
    inputBinding:
      position: 101
      prefix: -iterate
  - id: trim
    type:
      - 'null'
      - int
    doc: trim dataset
    inputBinding:
      position: 101
      prefix: -trim
  - id: split
    type:
      - 'null'
      - int
    doc: split dataset
    inputBinding:
      position: 101
      prefix: -split
  - id: trimfile
    type:
      - 'null'
      - string
    doc: trim dataset filename
    inputBinding:
      position: 101
      prefix: -trimfile
  - id: split_nseq_thres
    type:
      - 'null'
      - int
    doc: Maximum Number of sequences within a subgroup
    inputBinding:
      position: 101
      prefix: -split_nseq_thres
  - id: split_score_thres
    type:
      - 'null'
      - int
    doc: Minimum score within a split dataset
    inputBinding:
      position: 101
      prefix: -split_score_thres
  - id: check_pdb_status
    type:
      - 'null'
      - int
    doc: Reports the existance of a PDB file
    inputBinding:
      position: 101
      prefix: -check_pdb_status
  - id: clean_seq_name
    type:
      - 'null'
      - int
    doc: Remove Special Char from sequence names
    inputBinding:
      position: 101
      prefix: -clean_seq_name
  - id: seq_to_keep
    type:
      - 'null'
      - type: array
        items: string
    doc: File containing the name of the sequences to keep when triming OR a 
      list of names)
    inputBinding:
      position: 101
      prefix: -seq_to_keep
  - id: dpa_master_aln
    type:
      - 'null'
      - string
    doc: 'Approximate Alignment: File|method'
    inputBinding:
      position: 101
      prefix: -dpa_master_aln
  - id: dpa_maxnseq
    type:
      - 'null'
      - int
    doc: Maximum number of sequences to be aligned with DPA
    inputBinding:
      position: 101
      prefix: -dpa_maxnseq
  - id: dpa_min_score1
    type:
      - 'null'
      - type: array
        items: int
    doc: Minimum percent ID to merge sequences in the approximate alignment
    inputBinding:
      position: 101
      prefix: -dpa_min_score1
  - id: dpa_min_score2
    type:
      - 'null'
      - type: array
        items: int
    doc: Threshold for aligning a group in the slow double progressive alignment
      (automatically readjusted)
    inputBinding:
      position: 101
      prefix: -dpa_min_score2
  - id: dpa_keep_tmpfile
    type:
      - 'null'
      - boolean
    doc: Prevents deletion of the tmpfile generated by t_coffee_dpa
    inputBinding:
      position: 101
      prefix: -dpa_keep_tmpfile
  - id: dpa_debug
    type:
      - 'null'
      - int
    doc: DEbug mode for DPA ( causes dpa tmp files to be kept)
    inputBinding:
      position: 101
      prefix: -dpa_debug
  - id: multi_core
    type:
      - 'null'
      - string
    doc: 'Multi core: template_jobs_relax_[msa|pairwise]_evaluate'
    inputBinding:
      position: 101
      prefix: -multi_core
  - id: n_core
    type:
      - 'null'
      - int
    doc: Number of cores to be used by machine [default=1, 0=> all those defined
      in the environement]
    inputBinding:
      position: 101
      prefix: -n_core
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of cores to be used by machine [default=1, 0=> all those defined
      in the environement]
    inputBinding:
      position: 101
      prefix: -thread
  - id: max_n_proc
    type:
      - 'null'
      - int
    doc: Number of cores to be used by machine [default=1, 0=> all those defined
      in the environement]
    inputBinding:
      position: 101
      prefix: -max_n_proc
  - id: lib_list
    type:
      - 'null'
      - string
    doc: A File that contains every pair/group of sequence to process when 
      computing the lib, Format:<nseq> <index1><index2>
    inputBinding:
      position: 101
      prefix: -lib_list
  - id: prune_lib_mode
    type:
      - 'null'
      - string
    doc: A File that contains every pair/group of sequence to process when 
      computing the lib, Format:<nseq> <index1><index2>
    inputBinding:
      position: 101
      prefix: -prune_lib_mode
  - id: tip
    type:
      - 'null'
      - string
    doc: Controls The Output of A TIP When Computation is over [one,all,none]
    inputBinding:
      position: 101
      prefix: -tip
  - id: rna_lib
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: -rna_lib
  - id: no_warning
    type:
      - 'null'
      - int
    doc: Suppresses all Warnings
    inputBinding:
      position: 101
      prefix: -no_warning
  - id: run_local_script
    type:
      - 'null'
      - int
    doc: Run Local Script if in current directory
    inputBinding:
      position: 101
      prefix: -run_local_script
  - id: proxy
    type:
      - 'null'
      - string
    doc: proxy used to access to webservices, when required
    inputBinding:
      position: 101
      prefix: -proxy
  - id: email
    type:
      - 'null'
      - string
    doc: email provided to webservices, when required
    inputBinding:
      position: 101
      prefix: -email
  - id: clean_overaln
    type:
      - 'null'
      - int
    doc: Ratio between overaligned exon id Vs legitimates *100
    inputBinding:
      position: 101
      prefix: -clean_overaln
  - id: overaln_param
    type:
      - 'null'
      - type: array
        items: string
    doc: Parameters for the overaln
    inputBinding:
      position: 101
      prefix: -overaln_param
  - id: overaln_mode
    type:
      - 'null'
      - string
    doc: lower || uanlaign
    inputBinding:
      position: 101
      prefix: -overaln_mode
  - id: overaln_model
    type:
      - 'null'
      - string
    doc: fsa1 (no exon boundaries), fsa2 (exon boundaries)
    inputBinding:
      position: 101
      prefix: -overaln_model
  - id: overaln_threshold
    type:
      - 'null'
      - int
    doc: Ratio between overaligned exon id Vs legitimates *100
    inputBinding:
      position: 101
      prefix: -overaln_threshold
  - id: overaln_target
    type:
      - 'null'
      - int
    doc: Ratio between overaligned exon id Vs legitimates *100
    inputBinding:
      position: 101
      prefix: -overaln_target
  - id: overaln_p1
    type:
      - 'null'
      - int
    doc: Ratio between overaligned exon id Vs legitimates *100
    inputBinding:
      position: 101
      prefix: -overaln_P1
  - id: overaln_p2
    type:
      - 'null'
      - int
    doc: Ratio between overaligned exon id Vs legitimates *100
    inputBinding:
      position: 101
      prefix: -overaln_P2
  - id: overaln_p3
    type:
      - 'null'
      - int
    doc: Ratio between overaligned exon id Vs legitimates *100
    inputBinding:
      position: 101
      prefix: -overaln_P3
  - id: overaln_p4
    type:
      - 'null'
      - int
    doc: Ratio between overaligned exon id Vs legitimates *100
    inputBinding:
      position: 101
      prefix: -overaln_P4
  - id: exon_boundaries
    type:
      - 'null'
      - string
    doc: exon_boundaries [EBI boj format]
    inputBinding:
      position: 101
      prefix: -exon_boundaries
  - id: display
    type:
      - 'null'
      - int
    doc: Sets the threshold (nseq) for the full display of the groups. -1 
      results in a full display, and 0 in no display at all
    inputBinding:
      position: 101
      prefix: -display
outputs:
  - id: output_quiet
    type:
      - 'null'
      - Directory
    doc: Defines the file in which the log output is written
    outputBinding:
      glob: $(inputs.quiet)
  - id: output_full_log
    type:
      - 'null'
      - File[]
    doc: Sets the prefix of all the output files
    outputBinding:
      glob: $(inputs.full_log)*
  - id: output_run_name
    type:
      - 'null'
      - File[]
    doc: Sets the prefix of all the output files
    outputBinding:
      glob: $(inputs.run_name)*
  - id: output_out_lib
    type:
      - 'null'
      - File
    doc: Prompts the program to write the computed library file
    outputBinding:
      glob: $(inputs.out_lib)
  - id: output_outseqweight
    type:
      - 'null'
      - File
    doc: Prompts the program to write the sequuence weight values
    outputBinding:
      glob: $(inputs.outseqweight)
  - id: output_newtree
    type:
      - 'null'
      - File
    doc: Name of the output guide tree
    outputBinding:
      glob: $(inputs.newtree)
  - id: output_tree
    type:
      - 'null'
      - File
    doc: Name of the output guide tree
    outputBinding:
      glob: $(inputs.tree)
  - id: output_outfile
    type:
      - 'null'
      - File
    doc: Name of the output alignment
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/t-coffee:13.46.2.7c9e712d--pl5321hb2a3317_0
s:url: https://github.com/jashkenas/coffee-script-tmbundle
$namespaces:
  s: https://schema.org/
