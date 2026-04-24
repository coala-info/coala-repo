cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux pipeline
label: crux_pipeline
doc: "Run the Crux pipeline for peptide identification.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: mass_spectra
    type:
      type: array
      items: File
    doc: The name of the file(s) from which to parse the fragmentation spectra, 
      in any of the file formats supported by ProteoWizard. Alteratively, with 
      Tide-search, these files may be binary spectrum files produced by a 
      previous run of crux tide-search using the store-spectra parameter.
    inputBinding:
      position: 1
  - id: peptide_source
    type: string
    doc: Either the name of a file in fasta format from which to retrieve 
      proteins and peptides or an index created by a previous run of crux 
      tide-index (for Tide searching).
    inputBinding:
      position: 2
  - id: activation_method
    type:
      - 'null'
      - string
    doc: Specifies which scan types are searched.
    inputBinding:
      position: 103
      prefix: --activation_method
  - id: add_A_alanine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue A.
    inputBinding:
      position: 103
      prefix: --add_A_alanine
  - id: add_B_user_amino_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue B.
    inputBinding:
      position: 103
      prefix: --add_B_user_amino_acid
  - id: add_C_cysteine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue C.
    inputBinding:
      position: 103
      prefix: --add_C_cysteine
  - id: add_Cterm_peptide
    type:
      - 'null'
      - float
    doc: Specifiy a static modification to the c-terminus of all peptides.
    inputBinding:
      position: 103
      prefix: --add_Cterm_peptide
  - id: add_Cterm_protein
    type:
      - 'null'
      - float
    doc: Specify a static modification to the c-terminal peptide of each 
      protein.
    inputBinding:
      position: 103
      prefix: --add_Cterm_protein
  - id: add_D_aspartic_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue D.
    inputBinding:
      position: 103
      prefix: --add_D_aspartic_acid
  - id: add_E_glutamic_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue E.
    inputBinding:
      position: 103
      prefix: --add_E_glutamic_acid
  - id: add_F_phenylalanine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue F.
    inputBinding:
      position: 103
      prefix: --add_F_phenylalanine
  - id: add_G_glycine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue G.
    inputBinding:
      position: 103
      prefix: --add_G_glycine
  - id: add_H_histidine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue H.
    inputBinding:
      position: 103
      prefix: --add_H_histidine
  - id: add_I_isoleucine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue I.
    inputBinding:
      position: 103
      prefix: --add_I_isoleucine
  - id: add_J_user_amino_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue J.
    inputBinding:
      position: 103
      prefix: --add_J_user_amino_acid
  - id: add_K_lysine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue K.
    inputBinding:
      position: 103
      prefix: --add_K_lysine
  - id: add_L_leucine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue L.
    inputBinding:
      position: 103
      prefix: --add_L_leucine
  - id: add_M_methionine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue M.
    inputBinding:
      position: 103
      prefix: --add_M_methionine
  - id: add_N_asparagine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue N.
    inputBinding:
      position: 103
      prefix: --add_N_asparagine
  - id: add_Nterm_peptide
    type:
      - 'null'
      - float
    doc: Specify a static modification to the n-terminus of all peptides.
    inputBinding:
      position: 103
      prefix: --add_Nterm_peptide
  - id: add_Nterm_protein
    type:
      - 'null'
      - float
    doc: Specify a static modification to the n-terminal peptide of each 
      protein.
    inputBinding:
      position: 103
      prefix: --add_Nterm_protein
  - id: add_O_ornithine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue O.
    inputBinding:
      position: 103
      prefix: --add_O_ornithine
  - id: add_P_proline
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue P.
    inputBinding:
      position: 103
      prefix: --add_P_proline
  - id: add_Q_glutamine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue Q.
    inputBinding:
      position: 103
      prefix: --add_Q_glutamine
  - id: add_R_arginine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue R.
    inputBinding:
      position: 103
      prefix: --add_R_arginine
  - id: add_S_serine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue S.
    inputBinding:
      position: 103
      prefix: --add_S_serine
  - id: add_T_threonine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue T.
    inputBinding:
      position: 103
      prefix: --add_T_threonine
  - id: add_U_selenocysteine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue U.
    inputBinding:
      position: 103
      prefix: --add_U_selenocysteine
  - id: add_V_valine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue V.
    inputBinding:
      position: 103
      prefix: --add_V_valine
  - id: add_W_tryptophan
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue W.
    inputBinding:
      position: 103
      prefix: --add_W_tryptophan
  - id: add_X_user_amino_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue X.
    inputBinding:
      position: 103
      prefix: --add_X_user_amino_acid
  - id: add_Y_tyrosine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue Y.
    inputBinding:
      position: 103
      prefix: --add_Y_tyrosine
  - id: add_Z_user_amino_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue Z.
    inputBinding:
      position: 103
      prefix: --add_Z_user_amino_acid
  - id: allowed_missed_cleavage
    type:
      - 'null'
      - int
    doc: Maximum value is 5; for enzyme search.
    inputBinding:
      position: 103
      prefix: --allowed_missed_cleavage
  - id: auto_fragment_bin_tol
    type:
      - 'null'
      - string
    doc: Automatically estimate optimal value for the fragment_bin_tol parameter
      from the spectra themselves. false=no estimation, warn=try to estimate but
      use the default value in case of failure, fail=try to estimate and quit in
      case of failure.
    inputBinding:
      position: 103
      prefix: --auto_fragment_bin_tol
  - id: auto_mz_bin_width
    type:
      - 'null'
      - string
    doc: Automatically estimate optimal value for the mz-bin-width parameter 
      from the spectra themselves. false=no estimation, warn=try to estimate but
      use the default value in case of failure, fail=try to estimate and quit in
      case of failure.
    inputBinding:
      position: 103
      prefix: --auto-mz-bin-width
  - id: auto_peptide_mass_tolerance
    type:
      - 'null'
      - string
    doc: Automatically estimate optimal value for the peptide_mass_tolerancel 
      parameter from the spectra themselves. false=no estimation, warn=try to 
      estimate but use the default value in case of failure, fail=try to 
      estimate and quit in case of failure.
    inputBinding:
      position: 103
      prefix: --auto_peptide_mass_tolerance
  - id: auto_precursor_window
    type:
      - 'null'
      - string
    doc: Automatically estimate optimal value for the precursor-window parameter
      from the spectra themselves. false=no estimation, warn=try to estimate but
      use the default value in case of failure, fail=try to estimate and quit in
      case of failure.
    inputBinding:
      position: 103
      prefix: --auto-precursor-window
  - id: bullseye
    type:
      - 'null'
      - boolean
    doc: Run the Bullseye algorithm on the given MS data, using it to assign 
      high-resolution precursor values to the MS/MS data. If a spectrum file 
      ends with .ms2 or .cms2, matching .ms1/.cms1 files will be used as the MS1
      file. Otherwise, it is assumed that the spectrum file contains both MS1 
      and MS2 scans.
    inputBinding:
      position: 103
      prefix: --bullseye
  - id: bullseye_max_mass
    type:
      - 'null'
      - float
    doc: Only consider PPIDs below this maximum mass in daltons.
    inputBinding:
      position: 103
      prefix: --bullseye-max-mass
  - id: bullseye_min_mass
    type:
      - 'null'
      - float
    doc: Only consider PPIDs above this minimum mass in daltons.
    inputBinding:
      position: 103
      prefix: --bullseye-min-mass
  - id: c_neg
    type:
      - 'null'
      - float
    doc: Penalty for mistake made on negative examples. If not specified, then 
      this value is set by cross validation over {0.1, 1, 10}.
    inputBinding:
      position: 103
      prefix: --c-neg
  - id: c_pos
    type:
      - 'null'
      - float
    doc: Penalty for mistakes made on positive examples. If this value is set to
      0, then it is set via cross validation over the values {0.1, 1, 10}, 
      selecting the value that yields the largest number of PSMs identified at 
      the q-value threshold set via the --test-fdr parameter.
    inputBinding:
      position: 103
      prefix: --c-pos
  - id: clear_mz_range
    type:
      - 'null'
      - string
    doc: For iTRAQ/TMT type data; will clear out all peaks in the specified m/z 
      range.
    inputBinding:
      position: 103
      prefix: --clear_mz_range
  - id: clip_nterm_methionine
    type:
      - 'null'
      - int
    doc: 0=leave sequences as-is; 1=also consider sequence w/o N-term 
      methionine.
    inputBinding:
      position: 103
      prefix: --clip_nterm_methionine
  - id: combine_charge_states
    type:
      - 'null'
      - boolean
    doc: Specify this parameter to T in order to combine charge states with 
      peptide sequencesin peptide-centric search. Works only if 
      estimation-method = peptide-level.
    inputBinding:
      position: 103
      prefix: --combine-charge-states
  - id: combine_modified_peptides
    type:
      - 'null'
      - boolean
    doc: Specify this parameter to T in order to treat peptides carrying 
      different or no modifications as being the same. Works only if estimation 
      = peptide-level.
    inputBinding:
      position: 103
      prefix: --combine-modified-peptides
  - id: compute_sp
    type:
      - 'null'
      - boolean
    doc: Compute the preliminary score Sp for all candidate peptides. Report 
      this score in the output, along with the corresponding rank, the number of
      matched ions and the total number of ions. This option is recommended if 
      results are to be analyzed by Percolator or Barista. If sqt-output is 
      enabled, then compute-sp is automatically enabled and cannot be 
      overridden. Note that the Sp computation requires re-processing each 
      observed spectrum, so turning on this switch involves significant 
      computational overhead.
    inputBinding:
      position: 103
      prefix: --compute-sp
  - id: concat
    type:
      - 'null'
      - boolean
    doc: When set to T, target and decoy search results are reported in a single
      file, and only the top-scoring N matches (as specified via --top-match) 
      are reported for each spectrum, irrespective of whether the matches 
      involve target or decoy peptides.Note that when used with 
      search-for-xlinks, this parameter only has an effect if use-old-xlink=F.
    inputBinding:
      position: 103
      prefix: --concat
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Specifies the prefix of the protein names that indicates a decoy.
    inputBinding:
      position: 103
      prefix: --decoy_prefix
  - id: decoy_prefix_alt
    type:
      - 'null'
      - string
    doc: Specifies the prefix of the protein names that indicate a decoy.
    inputBinding:
      position: 103
      prefix: --decoy-prefix
  - id: decoy_search
    type:
      - 'null'
      - int
    doc: 0=no, 1=concatenated search, 2=separate search.
    inputBinding:
      position: 103
      prefix: --decoy_search
  - id: decoy_xml_output
    type:
      - 'null'
      - boolean
    doc: Include decoys (PSMs, peptides, and/or proteins) in the XML output.
    inputBinding:
      position: 103
      prefix: --decoy-xml-output
  - id: default_direction
    type:
      - 'null'
      - string
    doc: In its initial round of training, Percolator uses one feature to induce
      a ranking of PSMs. By default, Percolator will select the feature that 
      produces the largest set of target PSMs at a specified FDR threshold (cf. 
      --train-fdr). This option allows the user to specify which feature is used
      for the initial ranking, using the name as a string. The name can be 
      preceded by a hyphen (e.g. "-XCorr") to indicate that a lower value is 
      better.
    inputBinding:
      position: 103
      prefix: --default-direction
  - id: deisotope
    type:
      - 'null'
      - float
    doc: Perform a simple deisotoping operation across each MS2 spectrum. For 
      each peak in an MS2 spectrum, consider lower m/z peaks. If the current 
      peak occurs where an expected peak would lie for any charge state less 
      than the charge state of the precursor, within mass tolerance, and if the 
      current peak is of lower abundance, then the peak is removed. The value of
      this parameter is the mass tolerance, in units of parts-per-million. If 
      set to 0, no deisotoping is performed.
    inputBinding:
      position: 103
      prefix: --deisotope
  - id: digest_mass_range
    type:
      - 'null'
      - string
    doc: MH+ peptide mass range to analyze.
    inputBinding:
      position: 103
      prefix: --digest_mass_range
  - id: estimation_method
    type:
      - 'null'
      - string
    doc: Specify the method used to estimate q-values. The mix-max procedure or 
      target-decoy competition apply to PSMs. The peptide-level option 
      eliminates any PSM for which there exists a better scoring PSM involving 
      the same peptide, and then uses decoys to assign confidence estimates.
    inputBinding:
      position: 103
      prefix: --estimation-method
  - id: evidence_granularity
    type:
      - 'null'
      - int
    doc: When exact-pvalue=T, this parameter controls the granularity of the 
      entries in the dynamic programming matrix. Smaller values make the program
      run faster but give less exact p-values; larger values make the program 
      run more slowly but give more exact p-values.
    inputBinding:
      position: 103
      prefix: --evidence-granularity
  - id: exact_match
    type:
      - 'null'
      - boolean
    doc: When true, require an exact match (as defined by --exact-tolerance) 
      between the center of the precursor isolation window in the MS2 scan and 
      the base isotopic peak of the PPID. If this option is set to false and no 
      exact match is observed, then attempt to match using a wider m/z 
      tolerance. This wider tolerance is calculated using the PPID's 
      monoisotopic mass and charge (the higher the charge, the smaller the 
      window).
    inputBinding:
      position: 103
      prefix: --exact-match
  - id: exact_p_value
    type:
      - 'null'
      - boolean
    doc: Enable the calculation of exact p-values for the XCorr score. 
      Calculation of p-values increases the running time but increases the 
      number of identifications at a fixed confidence threshold. The p-values 
      will be reported in a new column with header "exact p-value", and the 
      "xcorr score" column will be replaced with a "refactored xcorr" column. 
      Note that, currently, p-values can only be computed when the mz-bin-width 
      parameter is set to its default value. Variable and static mods are 
      allowed on non-terminal residues in conjunction with p-value computation, 
      but currently only static mods are allowed on the N-terminus, and no mods 
      on the C-terminus.
    inputBinding:
      position: 103
      prefix: --exact-p-value
  - id: exact_tolerance
    type:
      - 'null'
      - float
    doc: Set the tolerance (+/-ppm) for --exact-match.
    inputBinding:
      position: 103
      prefix: --exact-tolerance
  - id: feature_file_out
    type:
      - 'null'
      - boolean
    doc: Output the computed features in tab-delimited Percolator input (.pin) 
      format. The features will be normalized, using either unit norm or 
      standard deviation normalization (depending upon the value of the 
      unit-norm option).
    inputBinding:
      position: 103
      prefix: --feature-file-out
  - id: fido_alpha
    type:
      - 'null'
      - float
    doc: Specify the probability with which a present protein emits an 
      associated peptide. Set by grid search (see --fido-gridsearch-depth 
      parameter) if not specified.
    inputBinding:
      position: 103
      prefix: --fido-alpha
  - id: fido_beta
    type:
      - 'null'
      - float
    doc: Specify the probability of the creation of a peptide from noise. Set by
      grid search (see --fido-gridsearch-depth parameter) if not specified.
    inputBinding:
      position: 103
      prefix: --fido-beta
  - id: fido_empirical_protein_q
    type:
      - 'null'
      - boolean
    doc: Estimate empirical p-values and q-values for proteins using 
      target-decoy analysis.
    inputBinding:
      position: 103
      prefix: --fido-empirical-protein-q
  - id: fido_fast_gridsearch
    type:
      - 'null'
      - float
    doc: Apply the specified threshold to PSM, peptide and protein probabilities
      to obtain a faster estimate of the alpha, beta and gamma parameters.
    inputBinding:
      position: 103
      prefix: --fido-fast-gridsearch
  - id: fido_gamma
    type:
      - 'null'
      - float
    doc: Specify the prior probability that a protein is present in the sample. 
      Set by grid search (see --fido-gridsearch-depth parameter) if not 
      specified.
    inputBinding:
      position: 103
      prefix: --fido-gamma
  - id: fido_gridsearch_depth
    type:
      - 'null'
      - int
    doc: Set depth of the grid search for alpha, beta and gamma estimation.
    inputBinding:
      position: 103
      prefix: --fido-gridsearch-depth
  - id: fido_gridsearch_mse_threshold
    type:
      - 'null'
      - float
    doc: Q-value threshold that will be used in the computation of the MSE and 
      ROC AUC score in the grid search.
    inputBinding:
      position: 103
      prefix: --fido-gridsearch-mse-threshold
  - id: fido_no_split_large_components
    type:
      - 'null'
      - boolean
    doc: Do not approximate the posterior distribution by allowing large graph 
      components to be split into subgraphs. The splitting is done by 
      duplicating peptides with low probabilities. Splitting continues until the
      number of possible configurations of each subgraph is below 2^18
    inputBinding:
      position: 103
      prefix: --fido-no-split-large-components
  - id: fido_protein_truncation_threshold
    type:
      - 'null'
      - float
    doc: To speed up inference, proteins for which none of the associated 
      peptides has a probability exceeding the specified threshold will be 
      assigned probability = 0.
    inputBinding:
      position: 103
      prefix: --fido-protein-truncation-threshold
  - id: file_column
    type:
      - 'null'
      - boolean
    doc: Include the file column in tab-delimited output.
    inputBinding:
      position: 103
      prefix: --file-column
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    inputBinding:
      position: 103
      prefix: --fileroot
  - id: fragment_bin_offset
    type:
      - 'null'
      - float
    doc: Offset position to start the binning (0.0 to 1.0).
    inputBinding:
      position: 103
      prefix: --fragment_bin_offset
  - id: fragment_bin_tol
    type:
      - 'null'
      - float
    doc: Binning to use on fragment ions.
    inputBinding:
      position: 103
      prefix: --fragment_bin_tol
  - id: fragment_tolerance
    type:
      - 'null'
      - float
    doc: Mass tolerance (in Da) for scoring pairs of peaks when creating the 
      residue evidence matrix. This parameter only makes sense when 
      score-function is 'residue-evidence' or 'both'.
    inputBinding:
      position: 103
      prefix: --fragment-tolerance
  - id: gap_tolerance
    type:
      - 'null'
      - int
    doc: Allowed gap size when checking for PPIDs across consecutive MS1 scans.
    inputBinding:
      position: 103
      prefix: --gap-tolerance
  - id: init_weights
    type:
      - 'null'
      - string
    doc: Read initial weights from the given file (one per line).
    inputBinding:
      position: 103
      prefix: --init-weights
  - id: isotope_error
    type:
      - 'null'
      - string
    doc: List of positive, non-zero integers.
    inputBinding:
      position: 103
      prefix: --isotope-error
  - id: isotope_error_alt
    type:
      - 'null'
      - int
    doc: 0=off, 1=on -1/0/1/2/3 (standard C13 error), 2=-8/-4/0/4/8 (for +4/+8 
      labeling).
    inputBinding:
      position: 103
      prefix: --isotope_error
  - id: klammer
    type:
      - 'null'
      - boolean
    doc: Use retention time features calculated as in "Improving tandem mass 
      spectrum identification using peptide retention time prediction across 
      diverse chromatography conditions" by Klammer AA, Yi X, MacCoss MJ and 
      Noble WS. (Analytical Chemistry. 2007 Aug 15;79(16):6111-8.).
    inputBinding:
      position: 103
      prefix: --klammer
  - id: list_of_files
    type:
      - 'null'
      - boolean
    doc: Specify that the search results are provided as lists of files, rather 
      than as individual files.
    inputBinding:
      position: 103
      prefix: --list-of-files
  - id: mass_offsets
    type:
      - 'null'
      - string
    doc: Specifies one or more mass offsets to apply. This value(s) are 
      effectively subtracted from each precursor mass such that peptides that 
      are smaller than the precursor mass by the offset value can still be 
      matched to the respective spectrum.
    inputBinding:
      position: 103
      prefix: --mass_offsets
  - id: mass_precision
    type:
      - 'null'
      - int
    doc: Set the precision for masses and m/z written to sqt and text files.
    inputBinding:
      position: 103
      prefix: --mass-precision
  - id: mass_type_fragment
    type:
      - 'null'
      - int
    doc: 0=average masses, 1=monoisotopic masses.
    inputBinding:
      position: 103
      prefix: --mass_type_fragment
  - id: mass_type_parent
    type:
      - 'null'
      - int
    doc: 0=average masses, 1=monoisotopic masses.
    inputBinding:
      position: 103
      prefix: --mass_type_parent
  - id: max_charge_feature
    type:
      - 'null'
      - int
    doc: Specifies the maximum charge state feature. When set to zero, use the 
      maximum observed charge state.
    inputBinding:
      position: 103
      prefix: --max-charge-feature
  - id: max_fragment_charge
    type:
      - 'null'
      - int
    doc: Set maximum fragment charge state to analyze (allowed max 5).
    inputBinding:
      position: 103
      prefix: --max_fragment_charge
  - id: max_persist
    type:
      - 'null'
      - float
    doc: Ignore PPIDs that persist for longer than this length of time in the 
      MS1 spectra. The unit of time is whatever unit is used in your data file 
      (usually minutes). These PPIDs are considered contaminants.
    inputBinding:
      position: 103
      prefix: --max-persist
  - id: max_precursor_charge
    type:
      - 'null'
      - int
    doc: The maximum charge state of a spectra to consider in search.
    inputBinding:
      position: 103
      prefix: --max-precursor-charge
  - id: max_precursor_charge_alt
    type:
      - 'null'
      - int
    doc: Set maximum precursor charge state to analyze (allowed max 9).
    inputBinding:
      position: 103
      prefix: --max_precursor_charge
  - id: max_variable_mods_in_peptide
    type:
      - 'null'
      - int
    doc: Specifies the total/maximum number of residues that can be modified in 
      a peptide.
    inputBinding:
      position: 103
      prefix: --max_variable_mods_in_peptide
  - id: maxiter
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for training.
    inputBinding:
      position: 103
      prefix: --maxiter
  - id: min_peaks
    type:
      - 'null'
      - int
    doc: The minimum number of peaks a spectrum must have for it to be searched.
    inputBinding:
      position: 103
      prefix: --min-peaks
  - id: minimum_intensity
    type:
      - 'null'
      - float
    doc: Minimum intensity value to read in.
    inputBinding:
      position: 103
      prefix: --minimum_intensity
  - id: minimum_peaks
    type:
      - 'null'
      - int
    doc: Minimum number of peaks in spectrum to search.
    inputBinding:
      position: 103
      prefix: --minimum_peaks
  - id: mod_precision
    type:
      - 'null'
      - int
    doc: Set the precision for modifications as written to .txt files.
    inputBinding:
      position: 103
      prefix: --mod-precision
  - id: ms_level
    type:
      - 'null'
      - int
    doc: MS level to analyze, valid are levels 2 or 3.
    inputBinding:
      position: 103
      prefix: --ms_level
  - id: mz_bin_offset
    type:
      - 'null'
      - float
    doc: In the discretization of the m/z axes of the observed and theoretical 
      spectra, this parameter specifies the location of the left edge of the 
      first bin, relative to mass = 0 (i.e., mz-bin-offset = 0.xx means the left
      edge of the first bin will be located at +0.xx Da).
    inputBinding:
      position: 103
      prefix: --mz-bin-offset
  - id: mz_bin_width
    type:
      - 'null'
      - float
    doc: Before calculation of the XCorr score, the m/z axes of the observed and
      theoretical spectra are discretized. This parameter specifies the size of 
      each bin. The exact formula for computing the discretized m/z value is 
      floor((x/mz-bin-width) + 1.0 - mz-bin-offset), where x is the observed m/z
      value. For low resolution ion trap ms/ms data 1.0005079 and for high 
      resolution ms/ms 0.02 is recommended.
    inputBinding:
      position: 103
      prefix: --mz-bin-width
  - id: mzid_output
    type:
      - 'null'
      - boolean
    doc: Output an mzIdentML results file to the output directory.
    inputBinding:
      position: 103
      prefix: --mzid-output
  - id: nucleotide_reading_frame
    type:
      - 'null'
      - int
    doc: 0=proteinDB, 1-6, 7=forward three, 8=reverse three, 9=all six.
    inputBinding:
      position: 103
      prefix: --nucleotide_reading_frame
  - id: num_enzyme_termini
    type:
      - 'null'
      - int
    doc: valid values are 1 (semi-digested), 2 (fully digested), 8 N-term, 9 
      C-term.
    inputBinding:
      position: 103
      prefix: --num_enzyme_termini
  - id: num_output_lines
    type:
      - 'null'
      - int
    doc: num peptide results to show.
    inputBinding:
      position: 103
      prefix: --num_output_lines
  - id: num_results
    type:
      - 'null'
      - int
    doc: Number of search hits to store internally.
    inputBinding:
      position: 103
      prefix: --num_results
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 0=poll CPU to set num threads; else specify num threads directly.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: num_threads_alt
    type:
      - 'null'
      - int
    doc: 0=poll CPU to set num threads; else specify num threads directly.
    inputBinding:
      position: 103
      prefix: --num_threads
  - id: only_psms
    type:
      - 'null'
      - boolean
    doc: Do not remove redundant peptides; keep all PSMs and exclude peptide 
      level probability.
    inputBinding:
      position: 103
      prefix: --only-psms
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: output_outfiles
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes  write .out files.
    inputBinding:
      position: 103
      prefix: --output_outfiles
  - id: output_pepxmlfile
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes  write pep.xml file.
    inputBinding:
      position: 103
      prefix: --output_pepxmlfile
  - id: output_percolatorfile
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes write percolator file.
    inputBinding:
      position: 103
      prefix: --output_percolatorfile
  - id: output_sqtfile
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes  write sqt file.
    inputBinding:
      position: 103
      prefix: --output_sqtfile
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: Specifies the suffix string that is appended to the base output name 
      for the pep.xml, pin.xml, txt and sqt output files.
    inputBinding:
      position: 103
      prefix: --output_suffix
  - id: output_txtfile
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes  write tab-delimited text file.
    inputBinding:
      position: 103
      prefix: --output_txtfile
  - id: output_weights
    type:
      - 'null'
      - boolean
    doc: Output final weights to a file named "percolator.weights.txt".
    inputBinding:
      position: 103
      prefix: --output-weights
  - id: override
    type:
      - 'null'
      - boolean
    doc: By default, Percolator will examine the learned weights for each 
      feature, and if the weight appears to be problematic, then percolator will
      discard the learned weights and instead employ a previously trained, 
      static score vector. This switch allows this error checking to be 
      overriden.
    inputBinding:
      position: 103
      prefix: --override
  - id: override_charge
    type:
      - 'null'
      - int
    doc: Specifies the whether to override existing precursor charge state 
      information when present in the files with the charge range specified by 
      the "precursor_charge" parameter.
    inputBinding:
      position: 103
      prefix: --override_charge
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: A file containing parameters.
    inputBinding:
      position: 103
      prefix: --parameter-file
  - id: peptide_centric_search
    type:
      - 'null'
      - boolean
    doc: Carries out a peptide-centric search. For each peptide the top-scoring 
      spectra are reported, in contrast to the standard spectrum-centric search 
      where the top-scoring peptides are reported. Note that in this case the 
      "xcorr rank" column will contain the rank of the given spectrum with 
      respect to the given candidate peptide, rather than vice versa (which is 
      the default).
    inputBinding:
      position: 103
      prefix: --peptide-centric-search
  - id: peptide_mass_tolerance
    type:
      - 'null'
      - float
    doc: Controls the mass tolerance value. The mass tolerance is set at +/- the
      specified number i.e. an entered value of "1.0" applies a -1.0 to +1.0 
      tolerance. The units of the mass tolerance is controlled by the parameter 
      "peptide_mass_units".
    inputBinding:
      position: 103
      prefix: --peptide_mass_tolerance
  - id: peptide_mass_units
    type:
      - 'null'
      - int
    doc: 0=amu, 1=mmu, 2=ppm.
    inputBinding:
      position: 103
      prefix: --peptide_mass_units
  - id: pepxml_output
    type:
      - 'null'
      - boolean
    doc: Output a pepXML results file to the output directory.
    inputBinding:
      position: 103
      prefix: --pepxml-output
  - id: percolator_seed
    type:
      - 'null'
      - string
    doc: When given a unsigned integer value seeds the random number generator 
      with that value. When given the string "time" seeds the random number 
      generator with the system time.
    inputBinding:
      position: 103
      prefix: --percolator-seed
  - id: persist_tolerance
    type:
      - 'null'
      - float
    doc: Set the mass tolerance (+/-ppm) for finding PPIDs in consecutive MS1 
      scans.
    inputBinding:
      position: 103
      prefix: --persist-tolerance
  - id: picked_protein
    type:
      - 'null'
      - string
    doc: Use the picked protein-level FDR to infer protein probabilities, 
      provide the fasta file as the argument to this flag.
    inputBinding:
      position: 103
      prefix: --picked-protein
  - id: pin_output
    type:
      - 'null'
      - boolean
    doc: Output a Percolator input (PIN) file to the output directory.
    inputBinding:
      position: 103
      prefix: --pin-output
  - id: pm_charge
    type:
      - 'null'
      - int
    doc: Precursor charge state to consider MS/MS spectra from, in measurement 
      error estimation. Ideally, this should be the most frequently occurring 
      charge state in the given data.
    inputBinding:
      position: 103
      prefix: --pm-charge
  - id: pm_max_frag_mz
    type:
      - 'null'
      - float
    doc: Maximum fragment m/z value to use in measurement error estimation.
    inputBinding:
      position: 103
      prefix: --pm-max-frag-mz
  - id: pm_max_precursor_delta_ppm
    type:
      - 'null'
      - float
    doc: Maximum ppm distance between precursor m/z values to consider two scans
      potentially generated by the same peptide for measurement error 
      estimation.
    inputBinding:
      position: 103
      prefix: --pm-max-precursor-delta-ppm
  - id: pm_max_precursor_mz
    type:
      - 'null'
      - float
    doc: Minimum precursor m/z value to use in measurement error estimation.
    inputBinding:
      position: 103
      prefix: --pm-max-precursor-mz
  - id: pm_max_scan_separation
    type:
      - 'null'
      - int
    doc: Maximum number of scans two spectra can be separated by in order to be 
      considered potentially generated by the same peptide, for measurement 
      error estimation.
    inputBinding:
      position: 103
      prefix: --pm-max-scan-separation
  - id: pm_min_common_frag_peaks
    type:
      - 'null'
      - int
    doc: Number of the most-intense peaks that two spectra must share in order 
      to potentially be generated by the same peptide, for measurement error 
      estimation.
    inputBinding:
      position: 103
      prefix: --pm-min-common-frag-peaks
  - id: pm_min_frag_mz
    type:
      - 'null'
      - float
    doc: Minimum fragment m/z value to use in measurement error estimation.
    inputBinding:
      position: 103
      prefix: --pm-min-frag-mz
  - id: pm_min_peak_pairs
    type:
      - 'null'
      - int
    doc: Minimum number of peak pairs (for precursor or fragment) that must be 
      successfully paired in order to attempt to estimate measurement error 
      distribution.
    inputBinding:
      position: 103
      prefix: --pm-min-peak-pairs
  - id: pm_min_precursor_mz
    type:
      - 'null'
      - float
    doc: Minimum precursor m/z value to use in measurement error estimation.
    inputBinding:
      position: 103
      prefix: --pm-min-precursor-mz
  - id: pm_min_scan_frag_peaks
    type:
      - 'null'
      - int
    doc: Minimum fragment peaks an MS/MS scan must contain to be used in 
      measurement error estimation.
    inputBinding:
      position: 103
      prefix: --pm-min-scan-frag-peaks
  - id: pm_pair_top_n_frag_peaks
    type:
      - 'null'
      - int
    doc: Number of fragment peaks per spectrum pair to be used in fragment error
      estimation.
    inputBinding:
      position: 103
      prefix: --pm-pair-top-n-frag-peaks
  - id: pm_top_n_frag_peaks
    type:
      - 'null'
      - int
    doc: Number of most-intense fragment peaks to consider for measurement error
      estimation, per MS/MS spectrum.
    inputBinding:
      position: 103
      prefix: --pm-top-n-frag-peaks
  - id: post_processor
    type:
      - 'null'
      - string
    doc: Specify which post-processor to apply to the search results.
    inputBinding:
      position: 103
      prefix: --post-processor
  - id: pout_output
    type:
      - 'null'
      - boolean
    doc: Output a Percolator pout.xml format results file to the output 
      directory.
    inputBinding:
      position: 103
      prefix: --pout-output
  - id: precision
    type:
      - 'null'
      - int
    doc: Set the precision for scores written to sqt and text files.
    inputBinding:
      position: 103
      prefix: --precision
  - id: precursor_charge_range
    type:
      - 'null'
      - string
    doc: Precursor charge range to analyze; does not override mzXML charge; 0 as
      first entry ignores parameter.
    inputBinding:
      position: 103
      prefix: --precursor_charge
  - id: precursor_tolerance_type
    type:
      - 'null'
      - int
    doc: 0=singly charged peptide mass, 1=precursor m/z.
    inputBinding:
      position: 103
      prefix: --precursor_tolerance_type
  - id: precursor_window
    type:
      - 'null'
      - float
    doc: Tolerance used for matching peptides to spectra. Peptides must be 
      within +/- 'precursor-window' of the spectrum value. The precursor window 
      units depend upon precursor-window-type.
    inputBinding:
      position: 103
      prefix: --precursor-window
  - id: precursor_window_type
    type:
      - 'null'
      - string
    doc: Specify the units for the window that is used to select peptides around
      the precursor mass location (mass, mz, ppm). The magnitude of the window 
      is defined by the precursor-window option, and candidate peptides must 
      fall within this window. For the mass window-type, the spectrum precursor 
      m+h value is converted to mass, and the window is defined as that mass +/-
      precursor-window. If the m+h value is not available, then the mass is 
      calculated from the precursor m/z and provided charge. The peptide mass is
      computed as the sum of the average amino acid masses plus 18 Da for the 
      terminal OH group. The mz window-type calculates the window as spectrum 
      precursor m/z +/- precursor-window and then converts the resulting m/z 
      range to the peptide mass range using the precursor charge. For the 
      parts-per-million (ppm) window-type, the spectrum mass is calculated as in
      the mass type. The lower bound of the mass window is then defined as the 
      spectrum mass / (1.0 + (precursor-window / 1000000)) and the upper bound 
      is defined as spectrum mass / (1.0 - (precursor-window / 1000000)).
    inputBinding:
      position: 103
      prefix: --precursor-window-type
  - id: print_expect_score
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes to replace Sp with expect in out & sqt.
    inputBinding:
      position: 103
      prefix: --print_expect_score
  - id: print_search_progress
    type:
      - 'null'
      - int
    doc: Show search progress by printing every n spectra searched. Set to 0 to 
      show no search progress.
    inputBinding:
      position: 103
      prefix: --print-search-progress
  - id: protein
    type:
      - 'null'
      - boolean
    doc: Use the Fido algorithm to infer protein probabilities. Must be true to 
      use any of the Fido options.
    inputBinding:
      position: 103
      prefix: --protein
  - id: protein_enzyme
    type:
      - 'null'
      - string
    doc: Type of enzyme
    inputBinding:
      position: 103
      prefix: --protein-enzyme
  - id: protein_report_duplicates
    type:
      - 'null'
      - boolean
    doc: If multiple database proteins contain exactly the same set of peptides,
      then Percolator will randomly discard all but one of the proteins. If this
      option is set, then the IDs of these duplicated proteins will be reported 
      as a comma-separated list. Not available for Fido.
    inputBinding:
      position: 103
      prefix: --protein-report-duplicates
  - id: protein_report_fragments
    type:
      - 'null'
      - boolean
    doc: By default, if the peptides associated with protein A are a proper 
      subset of the peptides associated with protein B, then protein A is 
      eliminated and all the peptides are considered as evidence for protein B. 
      Note that this filtering is done based on the complete set of peptides in 
      the database, not based on the identified peptides in the search results. 
      Alternatively, if this option is set and if all of the identified peptides
      associated with protein B are also associated with protein A, then 
      Percolator will report a comma-separated list of protein IDs, where the 
      full-length protein B is first in the list and the fragment protein A is 
      listed second. Not available for Fido.
    inputBinding:
      position: 103
      prefix: --protein-report-fragments
  - id: quick_validation
    type:
      - 'null'
      - boolean
    doc: Quicker execution by reduced internal cross-validation.
    inputBinding:
      position: 103
      prefix: --quick-validation
  - id: remove_precursor_peak
    type:
      - 'null'
      - boolean
    doc: If true, all peaks around the precursor m/z will be removed, within a 
      range specified by the --remove-precursor-tolerance option.
    inputBinding:
      position: 103
      prefix: --remove-precursor-peak
  - id: remove_precursor_peak_alt
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes, 2=all charge reduced precursor peaks (for ETD).
    inputBinding:
      position: 103
      prefix: --remove_precursor_peak
  - id: remove_precursor_tolerance
    type:
      - 'null'
      - float
    doc: This parameter specifies the tolerance (in Th) around each precursor 
      m/z that is removed when the --remove-precursor-peak option is invoked.
    inputBinding:
      position: 103
      prefix: --remove-precursor-tolerance
  - id: remove_precursor_tolerance_alt
    type:
      - 'null'
      - float
    doc: +- Da tolerance for precursor removal.
    inputBinding:
      position: 103
      prefix: --remove_precursor_tolerance
  - id: require_variable_mod
    type:
      - 'null'
      - int
    doc: Controls whether the analyzed peptides must contain at least one 
      variable modification.
    inputBinding:
      position: 103
      prefix: --require_variable_mod
  - id: retention_tolerance
    type:
      - 'null'
      - float
    doc: Set the tolerance (+/-units) around the retention time over which a 
      PPID can be matches to the MS2 spectrum. The unit of time is whatever unit
      is used in your data file (usually minutes).
    inputBinding:
      position: 103
      prefix: --retention-tolerance
  - id: sample_enzyme_number
    type:
      - 'null'
      - int
    doc: Sample enzyme which is possibly different than the one applied to the 
      search. Used to calculate NTT & NMC in pepXML output.
    inputBinding:
      position: 103
      prefix: --sample_enzyme_number
  - id: scan_number
    type:
      - 'null'
      - string
    doc: A single scan number or a range of numbers to be searched. Range should
      be specified as 'first-last' which will include scans 'first' and 'last'.
    inputBinding:
      position: 103
      prefix: --scan-number
  - id: scan_range
    type:
      - 'null'
      - string
    doc: Start and scan scan range to search; 0 as first entry ignores 
      parameter.
    inputBinding:
      position: 103
      prefix: --scan_range
  - id: scan_tolerance
    type:
      - 'null'
      - int
    doc: Total number of MS1 scans over which a PPID must be observed to be 
      considered real. Gaps in persistence are allowed by setting 
      --gap-tolerance.
    inputBinding:
      position: 103
      prefix: --scan-tolerance
  - id: score
    type:
      - 'null'
      - string
    doc: Specify the column (for tab-delimited input) or tag (for XML input) 
      used as input to the q-value estimation procedure. If this parameter is 
      unspecified, then the program searches for "xcorr score", "evalue" 
      (comet), "exact p-value" score fields in this order in the input file.
    inputBinding:
      position: 103
      prefix: --score
  - id: score_function
    type:
      - 'null'
      - string
    doc: Function used for scoring PSMs. 'xcorr' is the original scoring 
      function used by SEQUEST; 'residue-evidence' is designed to score 
      high-resolution MS2 spectra; and 'both' calculates both scores. The latter
      requires that exact-p-value=T.
    inputBinding:
      position: 103
      prefix: --score-function
  - id: search_engine
    type:
      - 'null'
      - string
    doc: Specify which search engine to use.
    inputBinding:
      position: 103
      prefix: --search-engine
  - id: search_enzyme_number
    type:
      - 'null'
      - int
    doc: Specify a search enzyme from the end of the parameter file.
    inputBinding:
      position: 103
      prefix: --search_enzyme_number
  - id: search_input
    type:
      - 'null'
      - string
    doc: "Specify the type of target-decoy search. Using 'auto', percolator attempts
      to detect the search type automatically. Using 'separate' specifies two searches:
      one against target and one against decoy protein db. Using 'concatenated' specifies
      a single search on concatenated target-decoy protein db."
    inputBinding:
      position: 103
      prefix: --search-input
  - id: show_fragment_ions
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes for out files only.
    inputBinding:
      position: 103
      prefix: --show_fragment_ions
  - id: sidak
    type:
      - 'null'
      - boolean
    doc: Adjust the score using the Sidak adjustment and reports them in a new 
      column in the output file. Note that this adjustment only makes sense if 
      the given scores are p-values, and that it requires the presence of the 
      "distinct matches/spectrum" feature for each PSM.
    inputBinding:
      position: 103
      prefix: --sidak
  - id: skip_preprocessing
    type:
      - 'null'
      - boolean
    doc: Skip preprocessing steps on spectra.
    inputBinding:
      position: 103
      prefix: --skip-preprocessing
  - id: skip_researching
    type:
      - 'null'
      - int
    doc: For '.out' file output only, 0=search everything again, 1=don't search 
      if .out exists.
    inputBinding:
      position: 103
      prefix: --skip_researching
  - id: spectral_counting_fdr
    type:
      - 'null'
      - float
    doc: Report the number of unique PSMs and total (including shared peptides) 
      PSMs as two extra columns in the protein tab-delimited output.
    inputBinding:
      position: 103
      prefix: --spectral-counting-fdr
  - id: spectrum_batch_size
    type:
      - 'null'
      - int
    doc: Maximum number of spectra to search at a time; 0 to search the entire 
      scan range in one loop.
    inputBinding:
      position: 103
      prefix: --spectrum_batch_size
  - id: spectrum_charge
    type:
      - 'null'
      - string
    doc: The spectrum charges to search. With 'all' every spectrum will be 
      searched and spectra with multiple charge states will be searched once at 
      each charge state. With 1, 2, or 3 only spectra with that charge state 
      will be searched.
    inputBinding:
      position: 103
      prefix: --spectrum-charge
  - id: spectrum_format
    type:
      - 'null'
      - string
    doc: The format to write the output spectra to. If empty, the spectra will 
      be output in the same format as the MS2 input.
    inputBinding:
      position: 103
      prefix: --spectrum-format
  - id: spectrum_max_mz
    type:
      - 'null'
      - float
    doc: The highest spectrum m/z to search in the ms2 file.
    inputBinding:
      position: 103
      prefix: --spectrum-max-mz
  - id: spectrum_min_mz
    type:
      - 'null'
      - float
    doc: The lowest spectrum m/z to search in the ms2 file.
    inputBinding:
      position: 103
      prefix: --spectrum-min-mz
  - id: spectrum_parser
    type:
      - 'null'
      - string
    doc: Specify the parser to use for reading in MS/MS spectra.
    inputBinding:
      position: 103
      prefix: --spectrum-parser
  - id: sqt_output
    type:
      - 'null'
      - boolean
    doc: Outputs an SQT results file to the output directory. Note that if 
      sqt-output is enabled, then compute-sp is automatically enabled and cannot
      be overridden.
    inputBinding:
      position: 103
      prefix: --sqt-output
  - id: store_index
    type:
      - 'null'
      - string
    doc: When providing a FASTA file as the index, the generated binary index 
      will be stored at the given path. This option has no effect if a binary 
      index is provided as the index.
    inputBinding:
      position: 103
      prefix: --store-index
  - id: store_spectra
    type:
      - 'null'
      - string
    doc: Specify the name of the file where the binarized fragmentation spectra 
      will be stored. Subsequent runs of crux tide-search will execute more 
      quickly if provided with the spectra in binary format. The filename is 
      specified relative to the current working directory, not the Crux output 
      directory (as specified by --output-dir). This option is not valid if 
      multiple input spectrum files are given.
    inputBinding:
      position: 103
      prefix: --store-spectra
  - id: subset_max_train
    type:
      - 'null'
      - int
    doc: Only train Percolator on a subset of PSMs, and use the resulting score 
      vector to evaluate the other PSMs. Recommended when analyzing huge numbers
      (>1 million) of PSMs. When set to 0, all PSMs are used for training as 
      normal.
    inputBinding:
      position: 103
      prefix: --subset-max-train
  - id: tdc
    type:
      - 'null'
      - boolean
    doc: Use target-decoy competition to assign q-values and PEPs. When set to 
      F, the mix-max method, which estimates the proportion pi0 of incorrect 
      target PSMs, is used instead.
    inputBinding:
      position: 103
      prefix: --tdc
  - id: test_each_iteration
    type:
      - 'null'
      - boolean
    doc: Measure performance on test set each iteration.
    inputBinding:
      position: 103
      prefix: --test-each-iteration
  - id: test_fdr
    type:
      - 'null'
      - float
    doc: False discovery rate threshold used in selecting hyperparameters during
      internal cross-validation and for reporting the final results.
    inputBinding:
      position: 103
      prefix: --test-fdr
  - id: theoretical_fragment_ions
    type:
      - 'null'
      - int
    doc: 0=default peak shape, 1=M peak only.
    inputBinding:
      position: 103
      prefix: --theoretical_fragment_ions
  - id: top_match
    type:
      - 'null'
      - int
    doc: Specify the number of matches to report for each spectrum.
    inputBinding:
      position: 103
      prefix: --top-match
  - id: top_match_in
    type:
      - 'null'
      - int
    doc: Specify the maximum rank to allow when parsing results files. Matches 
      with ranks higher than this value will be ignored (a value of zero allows 
      matches with any rank).
    inputBinding:
      position: 103
      prefix: --top-match-in
  - id: train_best_positive
    type:
      - 'null'
      - boolean
    doc: Enforce that, for each spectrum, at most one PSM is included in the 
      positive set during each training iteration. Note that if the user only 
      provides one PSM per spectrum, then this option will have no effect.
    inputBinding:
      position: 103
      prefix: --train-best-positive
  - id: train_fdr
    type:
      - 'null'
      - float
    doc: False discovery rate threshold to define positive examples in training.
    inputBinding:
      position: 103
      prefix: --train-fdr
  - id: txt_output
    type:
      - 'null'
      - boolean
    doc: Output a tab-delimited results file to the output directory.
    inputBinding:
      position: 103
      prefix: --txt-output
  - id: unitnorm
    type:
      - 'null'
      - boolean
    doc: Use unit normalization (i.e., linearly rescale each PSM's feature 
      vector to have a Euclidean length of 1), instead of standard deviation 
      normalization.
    inputBinding:
      position: 103
      prefix: --unitnorm
  - id: use_A_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not A-ions are considered in the search (0 - no, 1 
      - yes).
    inputBinding:
      position: 103
      prefix: --use_A_ions
  - id: use_B_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not B-ions are considered in the search (0 - no, 1 
      - yes).
    inputBinding:
      position: 103
      prefix: --use_B_ions
  - id: use_C_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not C-ions are considered in the search (0 - no, 1 
      - yes).
    inputBinding:
      position: 103
      prefix: --use_C_ions
  - id: use_NL_ions
    type:
      - 'null'
      - int
    doc: 0=no, 1= yes to consider NH3/H2O neutral loss peak.
    inputBinding:
      position: 103
      prefix: --use_NL_ions
  - id: use_X_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not X-ions are considered in the search (0 - no, 1 
      - yes).
    inputBinding:
      position: 103
      prefix: --use_X_ions
  - id: use_Y_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not Y-ions are considered in the search (0 - no, 1 
      - yes).
    inputBinding:
      position: 103
      prefix: --use_Y_ions
  - id: use_Z_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not Z-ions are considered in the search (0 - no, 1 
      - yes).
    inputBinding:
      position: 103
      prefix: --use_Z_ions
  - id: use_flanking_peaks
    type:
      - 'null'
      - boolean
    doc: Include flanking peaks around singly charged b and y theoretical ions. 
      Each flanking peak occurs in the adjacent m/z bin and has half the 
      intensity of the primary peak.
    inputBinding:
      position: 103
      prefix: --use-flanking-peaks
  - id: use_neutral_loss_peaks
    type:
      - 'null'
      - boolean
    doc: 'Controls whether neutral loss ions are considered in the search. Two types
      of neutral losses are included and are applied only to singly charged b- and
      y-ions: loss of ammonia (NH3, 17.0086343 Da) and H2O (18.0091422). Each neutral
      loss peak has intensity 1/5 of the primary peak.'
    inputBinding:
      position: 103
      prefix: --use-neutral-loss-peaks
  - id: use_z_line
    type:
      - 'null'
      - boolean
    doc: Specify whether, when parsing an MS2 spectrum file, Crux obtains the 
      precursor mass information from the "S" line or the "Z" line.
    inputBinding:
      position: 103
      prefix: --use-z-line
  - id: variable_mod01
    type:
      - 'null'
      - string
    doc: 'Up to 9 variable modifications are supported. Each modification is specified
      using seven entries: "<mass> <residues> <type> <max> <terminus> <distance> <force>."
      Type is 0 for static mods and non-zero for variable mods. Note that that if
      you set the same type value on multiple modification entries, Comet will treat
      those variable modifications as a binary set. This means that all modifiable
      residues in the binary set must be unmodified or modified. Multiple binary sets
      can be specified by setting a different binary modification value. Max is an
      integer specifying the maximum number of modified residues possible in a peptide
      for this modification entry. Distance specifies the distance the modification
      is applied to from the respective terminus: -1 = no distance contraint; 0 =
      only applies to terminal residue; N = only applies to terminal residue through
      next N residues. Terminus specifies which terminus the distance constraint is
      applied to: 0 = protein N-terminus; 1 = protein C-terminus; 2 = peptide N-terminus;
      3 = peptide C-terminus.Force specifies whether peptides must contain this modification:
      0 = not forced to be present; 1 = modification is required.'
    inputBinding:
      position: 103
      prefix: --variable_mod01
  - id: variable_mod02
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    inputBinding:
      position: 103
      prefix: --variable_mod02
  - id: variable_mod03
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    inputBinding:
      position: 103
      prefix: --variable_mod03
  - id: variable_mod04
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    inputBinding:
      position: 103
      prefix: --variable_mod04
  - id: variable_mod05
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    inputBinding:
      position: 103
      prefix: --variable_mod05
  - id: variable_mod06
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    inputBinding:
      position: 103
      prefix: --variable_mod06
  - id: variable_mod07
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    inputBinding:
      position: 103
      prefix: --variable_mod07
  - id: variable_mod08
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    inputBinding:
      position: 103
      prefix: --variable_mod08
  - id: variable_mod09
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    inputBinding:
      position: 103
      prefix: --variable_mod09
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_pipeline.out
