cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux comet
label: crux_comet
doc: "Comet is a widely used open-source tandem mass spectrometry search algorithm.\n\
  \nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: input_spectra
    type:
      type: array
      items: File
    doc: The name of the file from which to parse the spectra. Valid formats 
      include mzXML, mzML, mz5, raw, ms2, and cms2. Files in mzML or mzXML may 
      be compressed with gzip. RAW files can be parsed only under windows and if
      the appropriate libraries were included at compile time.
    inputBinding:
      position: 1
  - id: database_name
    type: File
    doc: A full or relative path to the sequence database, in FASTA format, to 
      search. Example databases include RefSeq or UniProt. The database can 
      contain amino acid sequences or nucleic acid sequences. If sequences are 
      amino acid sequences, set the parameter "nucleotide_reading_frame = 0". If
      the sequences are nucleic acid sequences, you must instruct Comet to 
      translate these to amino acid sequences. Do this by setting 
      nucleotide_reading_frame" to a value between 1 and 9.
    inputBinding:
      position: 2
  - id: activation_method
    type:
      - 'null'
      - string
    doc: Specifies which scan types are searched.
    default: ALL
    inputBinding:
      position: 103
      prefix: --activation_method
  - id: add_A_alanine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue A.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_A_alanine
  - id: add_B_user_amino_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue B.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_B_user_amino_acid
  - id: add_C_cysteine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue C.
    default: 57.021464
    inputBinding:
      position: 103
      prefix: --add_C_cysteine
  - id: add_Cterm_peptide
    type:
      - 'null'
      - float
    doc: Specifiy a static modification to the c-terminus of all peptides.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_Cterm_peptide
  - id: add_Cterm_protein
    type:
      - 'null'
      - float
    doc: Specify a static modification to the c-terminal peptide of each 
      protein.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_Cterm_protein
  - id: add_D_aspartic_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue D.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_D_aspartic_acid
  - id: add_E_glutamic_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue E.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_E_glutamic_acid
  - id: add_F_phenylalanine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue F.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_F_phenylalanine
  - id: add_G_glycine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue G.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_G_glycine
  - id: add_H_histidine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue H.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_H_histidine
  - id: add_I_isoleucine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue I.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_I_isoleucine
  - id: add_J_user_amino_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue J.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_J_user_amino_acid
  - id: add_K_lysine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue K.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_K_lysine
  - id: add_L_leucine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue L.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_L_leucine
  - id: add_M_methionine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue M.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_M_methionine
  - id: add_N_asparagine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue N.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_N_asparagine
  - id: add_Nterm_peptide
    type:
      - 'null'
      - float
    doc: Specify a static modification to the n-terminus of all peptides.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_Nterm_peptide
  - id: add_Nterm_protein
    type:
      - 'null'
      - float
    doc: Specify a static modification to the n-terminal peptide of each 
      protein.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_Nterm_protein
  - id: add_O_ornithine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue O.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_O_ornithine
  - id: add_P_proline
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue P.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_P_proline
  - id: add_Q_glutamine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue Q.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_Q_glutamine
  - id: add_R_arginine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue R.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_R_arginine
  - id: add_S_serine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue S.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_S_serine
  - id: add_T_threonine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue T.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_T_threonine
  - id: add_U_selenocysteine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue U.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_U_selenocysteine
  - id: add_V_valine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue V.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_V_valine
  - id: add_W_tryptophan
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue W.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_W_tryptophan
  - id: add_X_user_amino_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue X.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_X_user_amino_acid
  - id: add_Y_tyrosine
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue Y.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_Y_tyrosine
  - id: add_Z_user_amino_acid
    type:
      - 'null'
      - float
    doc: Specify a static modification to the residue Z.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --add_Z_user_amino_acid
  - id: allowed_missed_cleavage
    type:
      - 'null'
      - int
    doc: Maximum value is 5; for enzyme search.
    default: 2
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
    default: 'false'
    inputBinding:
      position: 103
      prefix: --auto_fragment_bin_tol
  - id: auto_peptide_mass_tolerance
    type:
      - 'null'
      - string
    doc: Automatically estimate optimal value for the peptide_mass_tolerancel 
      parameter from the spectra themselves. false=no estimation, warn=try to 
      estimate but use the default value in case of failure, fail=try to 
      estimate and quit in case of failure.
    default: 'false'
    inputBinding:
      position: 103
      prefix: --auto_peptide_mass_tolerance
  - id: clear_mz_range
    type:
      - 'null'
      - string
    doc: For iTRAQ/TMT type data; will clear out all peaks in the specified m/z 
      range.
    default: 0.0 0.0
    inputBinding:
      position: 103
      prefix: --clear_mz_range
  - id: clip_nterm_methionine
    type:
      - 'null'
      - int
    doc: 0=leave sequences as-is; 1=also consider sequence w/o N-term 
      methionine.
    default: 0
    inputBinding:
      position: 103
      prefix: --clip_nterm_methionine
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Specifies the prefix of the protein names that indicates a decoy.
    default: decoy_
    inputBinding:
      position: 103
      prefix: --decoy_prefix
  - id: decoy_search
    type:
      - 'null'
      - int
    doc: 0=no, 1=concatenated search, 2=separate search.
    default: 0
    inputBinding:
      position: 103
      prefix: --decoy_search
  - id: digest_mass_range
    type:
      - 'null'
      - string
    doc: MH+ peptide mass range to analyze.
    default: 600.0 5000.0
    inputBinding:
      position: 103
      prefix: --digest_mass_range
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    default: ''
    inputBinding:
      position: 103
      prefix: --fileroot
  - id: fragment_bin_offset
    type:
      - 'null'
      - float
    doc: Offset position to start the binning (0.0 to 1.0).
    default: 0.4
    inputBinding:
      position: 103
      prefix: --fragment_bin_offset
  - id: fragment_bin_tol
    type:
      - 'null'
      - float
    doc: Binning to use on fragment ions.
    default: 1.000507
    inputBinding:
      position: 103
      prefix: --fragment_bin_tol
  - id: isotope_error
    type:
      - 'null'
      - int
    doc: 0=off, 1=on -1/0/1/2/3 (standard C13 error), 2=-8/-4/0/4/8 (for +4/+8 
      labeling).
    default: 0
    inputBinding:
      position: 103
      prefix: --isotope_error
  - id: mass_offsets
    type:
      - 'null'
      - string
    doc: Specifies one or more mass offsets to apply. This value(s) are 
      effectively subtracted from each precursor mass such that peptides that 
      are smaller than the precursor mass by the offset value can still be 
      matched to the respective spectrum.
    default: ''
    inputBinding:
      position: 103
      prefix: --mass_offsets
  - id: mass_type_fragment
    type:
      - 'null'
      - int
    doc: 0=average masses, 1=monoisotopic masses.
    default: 1
    inputBinding:
      position: 103
      prefix: --mass_type_fragment
  - id: mass_type_parent
    type:
      - 'null'
      - int
    doc: 0=average masses, 1=monoisotopic masses.
    default: 1
    inputBinding:
      position: 103
      prefix: --mass_type_parent
  - id: max_fragment_charge
    type:
      - 'null'
      - int
    doc: Set maximum fragment charge state to analyze (allowed max 5).
    default: 3
    inputBinding:
      position: 103
      prefix: --max_fragment_charge
  - id: max_precursor_charge
    type:
      - 'null'
      - int
    doc: Set maximum precursor charge state to analyze (allowed max 9).
    default: 6
    inputBinding:
      position: 103
      prefix: --max_precursor_charge
  - id: max_variable_mods_in_peptide
    type:
      - 'null'
      - int
    doc: Specifies the total/maximum number of residues that can be modified in 
      a peptide.
    default: 5
    inputBinding:
      position: 103
      prefix: --max_variable_mods_in_peptide
  - id: minimum_intensity
    type:
      - 'null'
      - float
    doc: Minimum intensity value to read in.
    default: 0.0
    inputBinding:
      position: 103
      prefix: --minimum_intensity
  - id: minimum_peaks
    type:
      - 'null'
      - int
    doc: Minimum number of peaks in spectrum to search.
    default: 10
    inputBinding:
      position: 103
      prefix: --minimum_peaks
  - id: ms_level
    type:
      - 'null'
      - int
    doc: MS level to analyze, valid are levels 2 or 3.
    default: 2
    inputBinding:
      position: 103
      prefix: --ms_level
  - id: nucleotide_reading_frame
    type:
      - 'null'
      - int
    doc: 0=proteinDB, 1-6, 7=forward three, 8=reverse three, 9=all six.
    default: 0
    inputBinding:
      position: 103
      prefix: --nucleotide_reading_frame
  - id: num_enzyme_termini
    type:
      - 'null'
      - int
    doc: valid values are 1 (semi-digested), 2 (fully digested), 8 N-term, 9 
      C-term.
    default: 2
    inputBinding:
      position: 103
      prefix: --num_enzyme_termini
  - id: num_output_lines
    type:
      - 'null'
      - int
    doc: num peptide results to show.
    default: 5
    inputBinding:
      position: 103
      prefix: --num_output_lines
  - id: num_results
    type:
      - 'null'
      - int
    doc: Number of search hits to store internally.
    default: 50
    inputBinding:
      position: 103
      prefix: --num_results
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 0=poll CPU to set num threads; else specify num threads directly.
    default: 0
    inputBinding:
      position: 103
      prefix: --num_threads
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    default: crux-output
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: output_outfiles
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes write .out files.
    default: 0
    inputBinding:
      position: 103
      prefix: --output_outfiles
  - id: output_pepxmlfile
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes write pep.xml file.
    default: 1
    inputBinding:
      position: 103
      prefix: --output_pepxmlfile
  - id: output_percolatorfile
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes write percolator file.
    default: 0
    inputBinding:
      position: 103
      prefix: --output_percolatorfile
  - id: output_sqtfile
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes write sqt file.
    default: 0
    inputBinding:
      position: 103
      prefix: --output_sqtfile
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: Specifies the suffix string that is appended to the base output name 
      for the pep.xml, pin.xml, txt and sqt output files.
    default: ''
    inputBinding:
      position: 103
      prefix: --output_suffix
  - id: output_txtfile
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes write tab-delimited text file.
    default: 1
    inputBinding:
      position: 103
      prefix: --output_txtfile
  - id: override_charge
    type:
      - 'null'
      - int
    doc: Specifies the whether to override existing precursor charge state 
      information when present in the files with the charge range specified by 
      the "precursor_charge" parameter.
    default: 0
    inputBinding:
      position: 103
      prefix: --override_charge
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    default: false
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: A file containing parameters.
    default: ''
    inputBinding:
      position: 103
      prefix: --parameter-file
  - id: peptide_mass_tolerance
    type:
      - 'null'
      - float
    doc: Controls the mass tolerance value. The mass tolerance is set at +/- the
      specified number i.e. an entered value of "1.0" applies a -1.0 to +1.0 
      tolerance. The units of the mass tolerance is controlled by the parameter 
      "peptide_mass_units".
    default: 3.0
    inputBinding:
      position: 103
      prefix: --peptide_mass_tolerance
  - id: peptide_mass_units
    type:
      - 'null'
      - int
    doc: 0=amu, 1=mmu, 2=ppm.
    default: 0
    inputBinding:
      position: 103
      prefix: --peptide_mass_units
  - id: pm_charge
    type:
      - 'null'
      - int
    doc: Precursor charge state to consider MS/MS spectra from, in measurement 
      error estimation. Ideally, this should be the most frequently occurring 
      charge state in the given data.
    default: 2
    inputBinding:
      position: 103
      prefix: --pm-charge
  - id: pm_max_frag_mz
    type:
      - 'null'
      - float
    doc: Maximum fragment m/z value to use in measurement error estimation.
    default: 1800.0
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
    default: 50.0
    inputBinding:
      position: 103
      prefix: --pm-max-precursor-delta-ppm
  - id: pm_max_precursor_mz
    type:
      - 'null'
      - float
    doc: Minimum precursor m/z value to use in measurement error estimation.
    default: 1800.0
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
    default: 1000
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
    default: 20
    inputBinding:
      position: 103
      prefix: --pm-min-common-frag-peaks
  - id: pm_min_frag_mz
    type:
      - 'null'
      - float
    doc: Minimum fragment m/z value to use in measurement error estimation.
    default: 150.0
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
    default: 100
    inputBinding:
      position: 103
      prefix: --pm-min-peak-pairs
  - id: pm_min_precursor_mz
    type:
      - 'null'
      - float
    doc: Minimum precursor m/z value to use in measurement error estimation.
    default: 400.0
    inputBinding:
      position: 103
      prefix: --pm-min-precursor-mz
  - id: pm_min_scan_frag_peaks
    type:
      - 'null'
      - int
    doc: Minimum fragment peaks an MS/MS scan must contain to be used in 
      measurement error estimation.
    default: 40
    inputBinding:
      position: 103
      prefix: --pm-min-scan-frag-peaks
  - id: pm_pair_top_n_frag_peaks
    type:
      - 'null'
      - int
    doc: Number of fragment peaks per spectrum pair to be used in fragment error
      estimation.
    default: 5
    inputBinding:
      position: 103
      prefix: --pm-pair-top-n-frag-peaks
  - id: pm_top_n_frag_peaks
    type:
      - 'null'
      - int
    doc: Number of most-intense fragment peaks to consider for measurement error
      estimation, per MS/MS spectrum.
    default: 30
    inputBinding:
      position: 103
      prefix: --pm-top-n-frag-peaks
  - id: precursor_charge
    type:
      - 'null'
      - string
    doc: Precursor charge range to analyze; does not override mzXML charge; 0 as
      first entry ignores parameter.
    default: 0 0
    inputBinding:
      position: 103
      prefix: --precursor_charge
  - id: precursor_tolerance_type
    type:
      - 'null'
      - int
    doc: 0=singly charged peptide mass, 1=precursor m/z.
    default: 0
    inputBinding:
      position: 103
      prefix: --precursor_tolerance_type
  - id: print_expect_score
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes to replace Sp with expect in out & sqt.
    default: 1
    inputBinding:
      position: 103
      prefix: --print_expect_score
  - id: remove_precursor_peak
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes, 2=all charge reduced precursor peaks (for ETD).
    default: 0
    inputBinding:
      position: 103
      prefix: --remove_precursor_peak
  - id: remove_precursor_tolerance
    type:
      - 'null'
      - float
    doc: +- Da tolerance for precursor removal.
    default: 1.5
    inputBinding:
      position: 103
      prefix: --remove_precursor_tolerance
  - id: require_variable_mod
    type:
      - 'null'
      - int
    doc: Controls whether the analyzed peptides must contain at least one 
      variable modification.
    default: 0
    inputBinding:
      position: 103
      prefix: --require_variable_mod
  - id: sample_enzyme_number
    type:
      - 'null'
      - int
    doc: Sample enzyme which is possibly different than the one applied to the 
      search. Used to calculate NTT & NMC in pepXML output.
    default: 1
    inputBinding:
      position: 103
      prefix: --sample_enzyme_number
  - id: scan_range
    type:
      - 'null'
      - string
    doc: Start and scan scan range to search; 0 as first entry ignores 
      parameter.
    default: 0 0
    inputBinding:
      position: 103
      prefix: --scan_range
  - id: search_enzyme_number
    type:
      - 'null'
      - int
    doc: Specify a search enzyme from the end of the parameter file.
    default: 1
    inputBinding:
      position: 103
      prefix: --search_enzyme_number
  - id: show_fragment_ions
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes for out files only.
    default: 0
    inputBinding:
      position: 103
      prefix: --show_fragment_ions
  - id: skip_researching
    type:
      - 'null'
      - int
    doc: For '.out' file output only, 0=search everything again, 1=don't search 
      if .out exists.
    default: 1
    inputBinding:
      position: 103
      prefix: --skip_researching
  - id: spectrum_batch_size
    type:
      - 'null'
      - int
    doc: Maximum number of spectra to search at a time; 0 to search the entire 
      scan range in one loop.
    default: 0
    inputBinding:
      position: 103
      prefix: --spectrum_batch_size
  - id: theoretical_fragment_ions
    type:
      - 'null'
      - int
    doc: 0=default peak shape, 1=M peak only.
    default: 1
    inputBinding:
      position: 103
      prefix: --theoretical_fragment_ions
  - id: use_A_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not A-ions are considered in the search (0 - no, 1 
      - yes).
    default: 0
    inputBinding:
      position: 103
      prefix: --use_A_ions
  - id: use_B_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not B-ions are considered in the search (0 - no, 1 
      - yes).
    default: 1
    inputBinding:
      position: 103
      prefix: --use_B_ions
  - id: use_C_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not C-ions are considered in the search (0 - no, 1 
      - yes).
    default: 0
    inputBinding:
      position: 103
      prefix: --use_C_ions
  - id: use_NL_ions
    type:
      - 'null'
      - int
    doc: 0=no, 1= yes to consider NH3/H2O neutral loss peak.
    default: 1
    inputBinding:
      position: 103
      prefix: --use_NL_ions
  - id: use_X_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not X-ions are considered in the search (0 - no, 1 
      - yes).
    default: 0
    inputBinding:
      position: 103
      prefix: --use_X_ions
  - id: use_Y_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not Y-ions are considered in the search (0 - no, 1 
      - yes).
    default: 1
    inputBinding:
      position: 103
      prefix: --use_Y_ions
  - id: use_Z_ions
    type:
      - 'null'
      - int
    doc: Controls whether or not Z-ions are considered in the search (0 - no, 1 
      - yes).
    default: 0
    inputBinding:
      position: 103
      prefix: --use_Z_ions
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
    default: 0.0 null 0 4 -1 0 0
    inputBinding:
      position: 103
      prefix: --variable_mod01
  - id: variable_mod02
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    default: 0.0 null 0 4 -1 0 0
    inputBinding:
      position: 103
      prefix: --variable_mod02
  - id: variable_mod03
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    default: 0.0 null 0 4 -1 0 0
    inputBinding:
      position: 103
      prefix: --variable_mod03
  - id: variable_mod04
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    default: 0.0 null 0 4 -1 0 0
    inputBinding:
      position: 103
      prefix: --variable_mod04
  - id: variable_mod05
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    default: 0.0 null 0 4 -1 0 0
    inputBinding:
      position: 103
      prefix: --variable_mod05
  - id: variable_mod06
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    default: 0.0 null 0 4 -1 0 0
    inputBinding:
      position: 103
      prefix: --variable_mod06
  - id: variable_mod07
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    default: 0.0 null 0 4 -1 0 0
    inputBinding:
      position: 103
      prefix: --variable_mod07
  - id: variable_mod08
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    default: 0.0 null 0 4 -1 0 0
    inputBinding:
      position: 103
      prefix: --variable_mod08
  - id: variable_mod09
    type:
      - 'null'
      - string
    doc: See syntax for variable_mod01.
    default: 0.0 null 0 4 -1 0 0
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
    default: 30
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
stdout: crux_comet.out
