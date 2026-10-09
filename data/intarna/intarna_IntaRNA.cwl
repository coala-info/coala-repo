cwlVersion: v1.2
class: CommandLineTool
baseCommand: IntaRNA
label: intarna_IntaRNA
doc: "IntaRNA predicts RNA-RNA interactions.\n\nTool homepage: https://github.com/BackofenLab/IntaRNA"
inputs:
  - id: acc
    type:
      - 'null'
      - string
    doc: "accessibility computation : 'N' no accessibility contributions 'C' computation
      of accessibilities (see --accW and --accL)"
    inputBinding:
      position: 101
      prefix: --acc
  - id: helix_full_e
    type:
      - 'null'
      - boolean
    doc: if given (or true), the overall energy of a helix (including E_init, 
      ED, dangling ends, ..) will be used for helixMaxE checks; otherwise only 
      loop-terms are considered.
    inputBinding:
      position: 101
      prefix: --helixFullE
  - id: helix_max_bp
    type:
      - 'null'
      - int
    doc: maximal number of base pairs inside a helix (arg in range [2,20])
    inputBinding:
      position: 101
      prefix: --helixMaxBP
  - id: helix_max_e
    type:
      - 'null'
      - int
    doc: maximal energy (excluding) a helix may have (arg in range [-999,999]).
    inputBinding:
      position: 101
      prefix: --helixMaxE
  - id: helix_max_il
    type:
      - 'null'
      - int
    doc: maximal size for each internal loop size in a helix (arg in range 
      [0,2]).
    inputBinding:
      position: 101
      prefix: --helixMaxIL
  - id: helix_min_bp
    type:
      - 'null'
      - int
    doc: minimal number of base pairs inside a helix (arg in range [2,4])
    inputBinding:
      position: 101
      prefix: --helixMinBP
  - id: helix_min_pu
    type:
      - 'null'
      - float
    doc: minimal unpaired probability (per sequence) of considered helices (arg 
      in range [0,1]).
    inputBinding:
      position: 101
      prefix: --helixMinPu
  - id: int_len_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal window size to be considered for interaction
      (arg in range [0,99999]; 0 refers to the full sequence length). If --accW is
      provided, the smaller window size of both is used.'
    inputBinding:
      position: 101
      prefix: --intLenMax
  - id: int_loop_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal number of unpaired bases between neighbored interacting
      bases to be considered in interactions (arg in range [0,30]; 0 enforces stackings
      only)'
    inputBinding:
      position: 101
      prefix: --intLoopMax
  - id: mode
    type:
      - 'null'
      - string
    doc: "prediction mode : 'H' = heuristic (fast and low memory), 'M' = exact (slow),
      'S' = seed-only"
    inputBinding:
      position: 101
      prefix: --mode
  - id: model
    type:
      - 'null'
      - string
    doc: "interaction model : 'S' = single-site, minimum-free-energy interaction (interior
      loops only), 'X' = single-site, minimum-free-energy interaction via seed-extension
      (interior loops only), 'B' = single-site, helix-block-based, minimum-free-energy
      interaction (blocks of stable helices and interior loops only), 'P' = single-site
      interaction with minimal free ensemble energy per site (interior loops only)"
    inputBinding:
      position: 101
      prefix: --model
  - id: no_seed
    type:
      - 'null'
      - boolean
    doc: if given (or true), no seed is enforced within the predicted 
      interactions
    inputBinding:
      position: 101
      prefix: --noSeed
  - id: out_mode
    type:
      - 'null'
      - string
    doc: "output mode : 'N' normal output (ASCII char + energy), 'D' detailed output
      (ASCII char + energy/position details), 'C' CSV output (see --outCsvCols), 'E'
      ensemble information"
    inputBinding:
      position: 101
      prefix: --outMode
  - id: out_number
    type:
      - 'null'
      - int
    doc: number of (sub)optimal interactions to report (arg in range [0,1000])
    inputBinding:
      position: 101
      prefix: --outNumber
  - id: out_overlap
    type:
      - 'null'
      - string
    doc: "suboptimal output : interactions can overlap 'N' in none of the sequences,
      'T' in the target only, 'Q' in the query only, 'B' in both sequences"
    inputBinding:
      position: 101
      prefix: --outOverlap
  - id: out_sep
    type:
      - 'null'
      - string
    doc: column separator to be used in tabular CSV output
    inputBinding:
      position: 101
      prefix: --outSep
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: file from where to read additional command line arguments
    inputBinding:
      position: 101
      prefix: --parameterFile
  - id: personality
    type:
      - 'null'
      - string
    doc: IntaRNA personality to be used, which defines default values, available
      program arguments and tool behavior
    inputBinding:
      position: 101
      prefix: --personality
  - id: query
    type:
      - 'null'
      - string
    doc: either an RNA sequence or the stream/file name from where to read the 
      query sequences (should be the shorter sequences to increase efficiency); 
      use 'STDIN' to read from standard input stream; sequences have to use 
      IUPAC nucleotide encoding; output alias is [seq2]
    inputBinding:
      position: 101
      prefix: --query
  - id: seed_bp
    type:
      - 'null'
      - int
    doc: number of inter-molecular base pairs within the seed region (arg in 
      range [2,20])
    inputBinding:
      position: 101
      prefix: --seedBP
  - id: seed_tq
    type:
      - 'null'
      - string
    doc: comma separated list of explicit seed base pair encoding(s) in the 
      format startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', where 'startT/Q' are 
      the indices of the 5' seed ends in target/query sequence and 'bpsT/Q' the 
      respective dot-bar base pair encodings. This disables all other seed 
      constraints and seed identification.
    inputBinding:
      position: 101
      prefix: --seedTQ
  - id: target
    type:
      - 'null'
      - string
    doc: either an RNA sequence or the stream/file name from where to read the 
      target sequences (should be the longer sequences to increase efficiency); 
      use 'STDIN' to read from standard input stream; sequences have to use 
      IUPAC nucleotide encoding; output alias is [seq1]
    inputBinding:
      position: 101
      prefix: --target
  - id: threads
    type:
      - 'null'
      - int
    doc: maximal number of threads to be used for parallel computation of 
      query-target combinations. A value of 0 requests all available CPUs. Note,
      the number of threads multiplies the required memory used for computation!
      (arg in range [0,20])
    inputBinding:
      position: 101
      prefix: --threads
  - id: out_path
    type:
      - 'null'
      - string
    doc: 'output (multi-arg) : provide a file name for output (will be overwritten) or STDOUT/STDERR to write to the according stream; when not given, the result goes to standard output'
    inputBinding:
      position: 102
      prefix: --out
  - id: q_id
    type:
      - 'null'
      - string
    doc: 'id (FASTA-prefix) to be used for query sequence naming.'
    inputBinding:
      position: 101
      prefix: --qId
  - id: q_idx_pos0
    type:
      - 'null'
      - int
    doc: 'index of first (5'') sequence position of all query sequences (arg in range [-2000000000,2000000000];'
    inputBinding:
      position: 101
      prefix: --qIdxPos0
  - id: q_set
    type:
      - 'null'
      - string
    doc: 'query subset : List of sequence indices to consider for prediction in the format ''from1-to1,from2-to2,..'' assuming indexing starts with 1'
    inputBinding:
      position: 101
      prefix: --qSet
  - id: q_acc
    type:
      - 'null'
      - string
    doc: 'accessibility computation : ''N'' no accessibility contributions ''C'' computation of accessibilities ''P'' unpaired probabilities in RNAplfold format from --qAccFile ''E'' ED values in RNAplfold Pu-like format from --qAccFile'
    inputBinding:
      position: 101
      prefix: --qAcc
  - id: q_acc_w
    type:
      - 'null'
      - int
    doc: 'accessibility computation : sliding window size for query accessibility computation (arg in range [0,99999]; 0 will use to the full sequence length). Note, this also restricts the maximal interaction length (see --qIntLenMax).'
    inputBinding:
      position: 101
      prefix: --qAccW
  - id: q_acc_l
    type:
      - 'null'
      - int
    doc: 'accessibility computation : maximal loop length (base pair span) for query accessibility computation (arg in range [0,99999]; 0 will use to sliding window size ''qAccW'')'
    inputBinding:
      position: 101
      prefix: --qAccL
  - id: q_acc_constr
    type:
      - 'null'
      - string
    doc: 'accessibility computation : structure constraint : EITHER a string of query sequence length encoding for each position: ''.'' no constraint, ''x'' unpaired, ''p'' paired (intra-molecularly), or ''b'' blocked. Note, blocked positions are excluded from interaction prediction and constrained to be unpaired! OR an index range based encoding that is prefixed by the according constraint letter and a colon, e.g. ''b:3-4,33-40,p:1-2,12-20''. You might also want to check --energyAdd to correct the computed energies.'
    inputBinding:
      position: 101
      prefix: --qAccConstr
  - id: q_acc_file
    type:
      - 'null'
      - File
    doc: 'accessibility computation : the file/stream to be parsed, if --qAcc is to be read from file. Used ''STDIN'' if to read from standard input stream.'
    inputBinding:
      position: 101
      prefix: --qAccFile
  - id: q_int_len_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal window size to be considered for interaction (and thus accessible) within the query (arg in range [0,99999]; 0 defaults to the full sequence length) If --qAccW is provided, the smaller window size of both is used.'
    inputBinding:
      position: 101
      prefix: --qIntLenMax
  - id: q_int_loop_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal number of unpaired bases between neighbored interacting bases to be considered in interactions within the query (arg in range [0,30]; 0 enforces stackings only)'
    inputBinding:
      position: 101
      prefix: --qIntLoopMax
  - id: q_region
    type:
      - 'null'
      - string
    doc: 'interaction site : query regions to be considered for interaction prediction. Format = ''from1-to1,from2-to2,..'' where indexing starts with ''qIdxPos0''. Consider ''--qRegionLenMax'' for automatic region setup for long sequences.'
    inputBinding:
      position: 101
      prefix: --qRegion
  - id: q_region_len_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal length of highly accessible regions to be automatically identified. To this end, most inaccessible regions of length ''--seedBP'' are iteratively removed from the available indices until only regions below the given maximal length or remaining. (arg in range [0,99999]; 0 defaults to no automatic range detection)'
    inputBinding:
      position: 101
      prefix: --qRegionLenMax
  - id: q_pf_scale
    type:
      - 'null'
      - float
    doc: 'accessibility computation : partition function scaling parameter for query accessibility computation to avoid over-/underflow of data type range. See ViennaRNA package for details. (arg in range [1,99999];values below 1 are ignored)'
    inputBinding:
      position: 101
      prefix: --qPfScale
  - id: t_id
    type:
      - 'null'
      - string
    doc: 'id (FASTA-prefix) to be used for target sequence naming.'
    inputBinding:
      position: 101
      prefix: --tId
  - id: t_idx_pos0
    type:
      - 'null'
      - int
    doc: 'index of first (5'') sequence position of all target sequences (arg in range [-2000000000,2000000000];'
    inputBinding:
      position: 101
      prefix: --tIdxPos0
  - id: t_set
    type:
      - 'null'
      - string
    doc: 'target subset : List of sequence indices to consider for prediction in the format ''from1-to1,from2-to2,..'' assuming indexing starts with 1'
    inputBinding:
      position: 101
      prefix: --tSet
  - id: t_acc
    type:
      - 'null'
      - string
    doc: 'accessibility computation : ''N'' no accessibility contributions ''C'' computation of accessibilities ''P'' unpaired probabilities in RNAplfold format from --tAccFile ''E'' ED values in RNAplfold Pu-like format from --tAccFile'
    inputBinding:
      position: 101
      prefix: --tAcc
  - id: t_acc_w
    type:
      - 'null'
      - int
    doc: 'accessibility computation : sliding window size for target accessibility computation (arg in range [0,99999]; 0 will use the full sequence length) Note, this also restricts the maximal interaction length (see --tIntLenMax).'
    inputBinding:
      position: 101
      prefix: --tAccW
  - id: t_acc_l
    type:
      - 'null'
      - int
    doc: 'accessibility computation : maximal loop size (base pair span) for target accessibility computation (arg in range [0,99999]; 0 will use the sliding window size ''tAccW'')'
    inputBinding:
      position: 101
      prefix: --tAccL
  - id: t_acc_constr
    type:
      - 'null'
      - string
    doc: 'accessibility computation : structure constraint : EITHER a string of target sequence length encoding for each position: ''.'' no constraint, ''x'' unpaired, ''p'' paired (intra-molecularly), or ''b'' blocked. Note, blocked positions are excluded from interaction prediction and constrained to be unpaired! OR an index range based encoding that is prefixed by the according constraint letter and a colon, e.g. ''b:3-4,33-40,p:1-2,12-20''. You might also want to check --energyAdd to correct the computed energies.'
    inputBinding:
      position: 101
      prefix: --tAccConstr
  - id: t_acc_file
    type:
      - 'null'
      - File
    doc: 'accessibility computation : the file/stream to be parsed, if --tAcc is to be read from file. Used ''STDIN'' if to read from standard input stream.'
    inputBinding:
      position: 101
      prefix: --tAccFile
  - id: t_int_len_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal window size to be considered for interaction (and thus accessible) within the target (arg in range [0,99999]; 0 defaults to the full sequence length). If --tAccW is provided, the smaller window size of both is used.'
    inputBinding:
      position: 101
      prefix: --tIntLenMax
  - id: t_int_loop_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal number of unpaired bases between neighbored interacting bases to be considered in interactions within the target (arg in range [0,30]; 0 enforces stackings only)'
    inputBinding:
      position: 101
      prefix: --tIntLoopMax
  - id: t_region
    type:
      - 'null'
      - string
    doc: 'interaction site : target regions to be considered for interaction prediction. Format = ''from1-to1,from2-to2,..'' where indexing starts with ''tIdxPos0''. Consider ''--tRegionLenMax'' for automatic region setup for long sequences.'
    inputBinding:
      position: 101
      prefix: --tRegion
  - id: t_region_len_max
    type:
      - 'null'
      - int
    doc: 'interaction site : maximal length of highly accessible regions to be automatically identified. To this end, most inaccessible regions of length ''--seedBP'' are iteratively removed from the available indices until only regions below the given maximal length or remaining. (arg in range [0,99999]; 0 defaults to no automatic range detection)'
    inputBinding:
      position: 101
      prefix: --tRegionLenMax
  - id: t_pf_scale
    type:
      - 'null'
      - float
    doc: 'accessibility computation : partition function scaling parameter for target accessibility computation to avoid over-/underflow of data type range. See ViennaRNA package for details. (arg in range [1,99999];values below 1 are ignored)'
    inputBinding:
      position: 101
      prefix: --tPfScale
  - id: seed_max_up
    type:
      - 'null'
      - int
    doc: 'maximal overall number (query+target) of unpaired bases within the seed region (arg in range [0,20])'
    inputBinding:
      position: 101
      prefix: --seedMaxUP
  - id: seed_qmax_up
    type:
      - 'null'
      - int
    doc: 'maximal number of unpaired bases within the query''s seed region (arg in range [-1,20]); if -1 the value of seedMaxUP is used.'
    inputBinding:
      position: 101
      prefix: --seedQMaxUP
  - id: seed_tmax_up
    type:
      - 'null'
      - int
    doc: 'maximal number of unpaired bases within the target''s seed region (arg in range [-1,20]); if -1 the value of seedMaxUP is used.'
    inputBinding:
      position: 101
      prefix: --seedTMaxUP
  - id: seed_max_e
    type:
      - 'null'
      - int
    doc: 'maximal energy a seed region may have (arg in range [-999,999]).'
    inputBinding:
      position: 101
      prefix: --seedMaxE
  - id: seed_max_ehybrid
    type:
      - 'null'
      - int
    doc: 'maximal hybridization energy (including E_init) a seed region may have (arg in range [-999,999]).'
    inputBinding:
      position: 101
      prefix: --seedMaxEhybrid
  - id: seed_min_pu
    type:
      - 'null'
      - int
    doc: 'minimal unpaired probability (per sequence) a seed region may have (arg in range [0,1]).'
    inputBinding:
      position: 101
      prefix: --seedMinPu
  - id: seed_qrange
    type:
      - 'null'
      - string
    doc: 'interval(s) in the query to search for seeds in format ''from1-to1,from2-to2,.. .'' (Note, only for single query)'
    inputBinding:
      position: 101
      prefix: --seedQRange
  - id: seed_trange
    type:
      - 'null'
      - string
    doc: 'interval(s) in the target to search for seeds in format ''from1-to1,from2-to2,.. .'' (Note, only for single target)'
    inputBinding:
      position: 101
      prefix: --seedTRange
  - id: seed_no_gu
    type:
      - 'null'
      - boolean
    doc: 'if given (or true), no GU base pairs are allowed within seeds'
    inputBinding:
      position: 101
      prefix: --seedNoGU
  - id: seed_no_guend
    type:
      - 'null'
      - boolean
    doc: 'if given (or true), no GU base pairs are allowed at seed ends'
    inputBinding:
      position: 101
      prefix: --seedNoGUend
  - id: q_shape
    type:
      - 'null'
      - File
    doc: 'file name from where to read the query sequence''s SHAPE reactivity data to guide its accessibility computation'
    inputBinding:
      position: 101
      prefix: --qShape
  - id: t_shape
    type:
      - 'null'
      - File
    doc: 'SHAPE: file name from where to read the target sequence''s SHAPE reactivity data to guide its accessibility computation'
    inputBinding:
      position: 101
      prefix: --tShape
  - id: q_shape_method
    type:
      - 'null'
      - string
    doc: 'SHAPE: method how to integrate SHAPE reactivity data into query accessibility computation via pseudo energies: ''D'': Convert by using a linear equation according to Deigan et al. (2009). The calculated pseudo energies will be applied for every nucleotide involved in a stacked pair. The slope ''m'' and the intercept ''b'' can be set using e.g. ''Dm1.8b-0.6'' (=defaults for ''D''). ''Z'': Convert according to Zarringhalam et al. (2012) via pairing probabilities by using linear mapping. Aberration from the observed pairing probabilities will be penalized, which can be adjusted by the factor beta e.g. ''Zb0.89'' (=default for ''Z''). ''W'': Apply a given vector of perturbation energies to unpaired nucleotides according to Washietl et al. (2012). Perturbation vectors can be calculated by using RNApvmin.'
    inputBinding:
      position: 101
      prefix: --qShapeMethod
  - id: t_shape_method
    type:
      - 'null'
      - string
    doc: 'SHAPE: method how to integrate SHAPE reactivity data into target accessibility computation via pseudo energies. [for encodings see --qShapeMethod]'
    inputBinding:
      position: 101
      prefix: --tShapeMethod
  - id: q_shape_conversion
    type:
      - 'null'
      - string
    doc: 'SHAPE: method how to convert SHAPE reactivities to pairing probabilities for query accessibility computation. This parameter is useful when dealing with the SHAPE incorporation according to Zarringhalam et al. (2012). The following methods can be used to convert SHAPE reactivities into the probability for a certain nucleotide to be unpaired: ''M'': Linear mapping according to Zarringhalam et al. (2012) ''C'': Use a cutoff-approach to divide into paired and unpaired nucleotides, e.g. ''C0.25'' (= default for ''C'') ''S'': Skip the normalizing step since the input data already represents probabilities for being unpaired rather than raw reactivity values ''L'': Linear model to convert reactivity into a probability for being unpaired, e.g. ''Ls0.68i0.2'' for slope of 0.68 and intercept of 0.2 (=default for ''L'') ''O'': Linear model to convert the log reactivity into a probability for being unpaired, e.g. ''Os1.6i-2.29'' to use a slope of 1.6 and an intercept of -2.29 (=default for ''O'')'
    inputBinding:
      position: 101
      prefix: --qShapeConversion
  - id: t_shape_conversion
    type:
      - 'null'
      - string
    doc: 'SHAPE: method how to convert SHAPE reactivities to pairing probabilities for target accessibility computation. [for encodings see --qShapeConversion]'
    inputBinding:
      position: 101
      prefix: --tShapeConversion
  - id: acc_w
    type:
      - 'null'
      - int
    doc: 'accessibility computation : sliding window size for accessibility computation (arg in range [0,99999]; 0 will use the full sequence length) Note, this also restricts the maximal interaction length (see --intLenMax).'
    inputBinding:
      position: 101
      prefix: --accW
  - id: acc_l
    type:
      - 'null'
      - int
    doc: 'accessibility computation : maximal loop size (base pair span) for accessibility computation (arg in range [0,99999]; 0 will use the sliding window size ''accW'')'
    inputBinding:
      position: 101
      prefix: --accL
  - id: energy
    type:
      - 'null'
      - string
    doc: 'energy computation : ''B'' base pair energy -1 (Nussinov-like, i.e. independently of context), or ''V'' VRNA-based computation (Nearest-Neighbor model, see also --energVRNA)'
    inputBinding:
      position: 101
      prefix: --energy
  - id: energy_vrna
    type:
      - 'null'
      - string
    doc: 'energy parameter file of VRNA package to be used. Directly provided models are - Turner99 - Turner04 - Andronescu07 If not provided, the ''Turner04'' parameter set of the linked Vienna RNA package is used.'
    inputBinding:
      position: 101
      prefix: --energyVRNA
  - id: energy_no_dangles
    type:
      - 'null'
      - boolean
    doc: 'if given (or true), no dangling end contributions are considered within the overall interaction energy'
    inputBinding:
      position: 101
      prefix: --energyNoDangles
  - id: acc_no_lp
    type:
      - 'null'
      - boolean
    doc: 'if given (or true), no lonely base pairs are considered for accessibility computation'
    inputBinding:
      position: 101
      prefix: --accNoLP
  - id: acc_no_guend
    type:
      - 'null'
      - boolean
    doc: 'if given (or true), no GU-helix-ends are considered for accessibility computation'
    inputBinding:
      position: 101
      prefix: --accNoGUend
  - id: energy_add
    type:
      - 'null'
      - int
    doc: 'energy computation : if provided, this term is added to compute the overall energy of an interaction. This is useful to incorporate the energy shift of applied accessibility constraints.'
    inputBinding:
      position: 101
      prefix: --energyAdd
  - id: temperature
    type:
      - 'null'
      - int
    doc: 'temperature in Celsius to setup the VRNA energy parameters (arg in range [0,100])'
    inputBinding:
      position: 101
      prefix: --temperature
  - id: window_width
    type:
      - 'null'
      - int
    doc: 'Window-based computation: width of the window to be used; 0 disables window-based computation (arg in range [0,99999])'
    inputBinding:
      position: 101
      prefix: --windowWidth
  - id: window_overlap
    type:
      - 'null'
      - int
    doc: 'Window-based computation: overlap of the window to be used. Has to be smaller than --windowWidth and greater or equal than the maximal interaction length (see --q|tIntLenMax). (arg in range [0,99999])'
    inputBinding:
      position: 101
      prefix: --windowOverlap
  - id: out_max_e
    type:
      - 'null'
      - int
    doc: 'only interactions with E < maxE are reported (arg in range [-999,999])'
    inputBinding:
      position: 101
      prefix: --outMaxE
  - id: out_min_pu
    type:
      - 'null'
      - int
    doc: 'only interactions where all individual positions of both interacting sites have an unpaired probability >= minPu are reported (arg in range [0,1])'
    inputBinding:
      position: 101
      prefix: --outMinPu
  - id: out_delta_e
    type:
      - 'null'
      - int
    doc: 'suboptimal output : only interactions with E <= (minE+deltaE) are reported (arg in range [0,100])'
    inputBinding:
      position: 101
      prefix: --outDeltaE
  - id: out_best_seed_only
    type:
      - 'null'
      - boolean
    doc: 'if given (or true), only the energetically best putative seed is reported'
    inputBinding:
      position: 101
      prefix: --outBestSeedOnly
  - id: out_no_lp
    type:
      - 'null'
      - boolean
    doc: 'if given (or true), no lonely (non-stacked) inter-molecular base pairs are allowed in predictions'
    inputBinding:
      position: 101
      prefix: --outNoLP
  - id: out_no_guend
    type:
      - 'null'
      - boolean
    doc: 'if given (or true), no GU inter-molecular base pairs are allowed at interaction ends and interior loops (helix ends)'
    inputBinding:
      position: 101
      prefix: --outNoGUend
  - id: out_csv_cols
    type:
      - 'null'
      - string
    doc: 'output : comma separated list of CSV column IDs to print if outMode=C. Using ''*'' or an empty argument ('''') prints all possible columns from the following available ID list: id1, id2, seq1, seq2, subseq1, subseq2, subseqDP, subseqDB, start1, end1, start2, end2, hybridDP, hybridDB, hybridDPfull, hybridDBfull, bpList, E, Etotal, ED1, ED2, Pu1, Pu2, E_init, E_loops, E_dangleL, E_dangleR, E_endL, E_endR, E_hybrid, E_norm, E_hybridNorm, E_add, seedStart1, seedEnd1, seedStart2, seedEnd2, seedE, seedED1, seedED2, seedPu1, seedPu2, w, Eall, Eall1, Eall2, Zall, Zall1, Zall2, EallTotal, P_E, RT. Default = ''id1,start1,end1,id2,start2,e nd2,subseqDP,hybridDP,E''.'
    inputBinding:
      position: 101
      prefix: --outCsvCols
  - id: out_csv_sort
    type:
      - 'null'
      - string
    doc: 'output : column ID from [outCsvCols] to be used for CSV row sorting if outMode=C.'
    inputBinding:
      position: 101
      prefix: --outCsvSort
  - id: out_per_region
    type:
      - 'null'
      - boolean
    doc: 'output : if given (or true), best interactions are reported independently for all region combinations; otherwise only the best for each query-target combination'
    inputBinding:
      position: 101
      prefix: --outPerRegion
  - id: out_pairwise
    type:
      - 'null'
      - boolean
    doc: 'output : if given (or true), interactions are only computed for each corresponding query-target pair (same index) instead of all-vs-all'
    inputBinding:
      position: 101
      prefix: --outPairwise
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (interaction predictions when --out is not set)
  - id: out
    type:
      - 'null'
      - File
    doc: "output (multi-arg) : provide a file name for output (will be overwritten)
      or 'STDOUT/STDERR' to write to the according stream (according to --outMode).
      Use one of the following PREFIXES (colon-separated) to generate ADDITIONAL output:
      'qMinE:' (query) for each position the minimal energy of any interaction covering
      the position (CSV format) 'qSpotProb:' (query) for each position the probability
      that is is covered by an interaction covering (CSV format) 'qAcc:' (query) ED
      accessibility values ('qPu'-like format). 'qPu:' (query) unpaired probabilities
      values (RNAplfold format). 'tMinE:' (target) for each position the minimal energy
      of any interaction covering the position (CSV format) 'tSpotProb:' (target)
      for each position the probability that is is covered by an interaction covering
      (CSV format) 'tAcc:' (target) ED accessibility values ('tPu'-like format). 'tPu:'
      (target) unpaired probabilities values (RNAplfold format). 'pMinE:' (target+query)
      for each index pair the minimal energy of any interaction covering the pair
      (CSV format) 'spotProb:' (target+query) tracks for a given set of interaction
      spots their probability to be covered by an interaction. If no spots are provided,
      probabilities for all index combinations are computed. Spots are encoded by
      comma-separated 'idxT&idxQ' pairs (target-query). For each spot a probability
      is provided in concert with the probability that none of the spots (encoded
      by '0&0') is covered (CSV format). The spot encoding is followed colon-separated
      by the output stream/file name, eg. '--out=\"spotProb:3&76,59&2:STDERR\"'. NOTE:
      value has to be quoted due to '&' symbol! For each, provide a file name or STDOUT/STDERR
      to write to the respective output stream."
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
stdout: intarna_IntaRNA.out
