cwlVersion: v1.2
class: CommandLineTool
baseCommand: philosopher msfragger
label: philosopher_msfragger
doc: "MSFragger is a fast and accurate mass spectrometry data analysis tool for peptide
  identification.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: add_a_alanine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_A_alanine
  - id: add_c_cysteine
    type:
      - 'null'
      - float
    default: 57.021464
    inputBinding:
      position: 101
      prefix: --add_C_cysteine
  - id: add_cterm_peptide
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_Cterm_peptide
  - id: add_cterm_protein
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_Cterm_protein
  - id: add_d_aspartic_acid
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_D_aspartic_acid
  - id: add_e_glutamic_acid
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_E_glutamic_acid
  - id: add_f_phenylalanine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_F_phenylalanine
  - id: add_g_glycine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_G_glycine
  - id: add_h_histidine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_H_histidine
  - id: add_i_isoleucine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_I_isoleucine
  - id: add_k_lysine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_K_lysine
  - id: add_l_leucine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_L_leucine
  - id: add_m_methionine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_M_methionine
  - id: add_n_asparagine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_N_asparagine
  - id: add_nterm_peptide
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_Nterm_peptide
  - id: add_nterm_protein
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_Nterm_protein
  - id: add_p_proline
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_P_proline
  - id: add_q_glutamine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_Q_glutamine
  - id: add_r_arginine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_R_arginine
  - id: add_s_serine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_S_serine
  - id: add_t_threonine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_T_threonine
  - id: add_topn_complementary
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --add_topN_complementary
  - id: add_v_valine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_V_valine
  - id: add_w_tryptophan
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_W_tryptophan
  - id: add_y_tyrosine
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --add_Y_tyrosine
  - id: allow_multiple_variable_mods_on_residue
    type:
      - 'null'
      - int
    doc: static mods are not considered
    inputBinding:
      position: 101
      prefix: --allow_multiple_variable_mods_on_residue
  - id: allowed_missed_cleavage_1
    type:
      - 'null'
      - int
    doc: First enzyme's allowed number of missed cleavages per peptide. Maximum 
      value is 5.
    default: 2
    inputBinding:
      position: 101
      prefix: --allowed_missed_cleavage_1
  - id: allowed_missed_cleavage_2
    type:
      - 'null'
      - int
    doc: Second enzyme's allowed number of missed cleavages per peptide. Maximum
      value is 5.
    default: 2
    inputBinding:
      position: 101
      prefix: --allowed_missed_cleavage_2
  - id: calibrate_mass
    type:
      - 'null'
      - int
    doc: 0=Off, 1=On, 2=On and find optimal parameters
    inputBinding:
      position: 101
      prefix: --calibrate_mass
  - id: check_spectral_files_before_searching
    type:
      - 'null'
      - int
    default: 1
    inputBinding:
      position: 101
      prefix: --check the spectral files before searching
  - id: clear_mz_range
    type:
      - 'null'
      - string
    default: 0.0 0.0
    inputBinding:
      position: 101
      prefix: --clear_mz_range
  - id: clip_nterm_m
    type:
      - 'null'
      - int
    default: 1
    inputBinding:
      position: 101
      prefix: --clip_nTerm_M
  - id: data_type
    type:
      - 'null'
      - int
    doc: 0 for DDA, 1 for DIA, 2 for DIA-narrow-window
    inputBinding:
      position: 101
      prefix: --data_type
  - id: database_name
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --database_name
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: prefix added to the decoy protein ID (used for parameter optimization 
      only)
    default: rev_
    inputBinding:
      position: 101
      prefix: --decoy_prefix
  - id: deisotope
    type:
      - 'null'
      - int
    doc: Perform deisotoping or not (0=no, 1=yes and assume singleton peaks 
      single charged, 2=yes and assume singleton
    default: 1
    inputBinding:
      position: 101
      prefix: --deisotope
  - id: deneutralloss
    type:
      - 'null'
      - int
    doc: Perform deneutrallossing or not (0=no, 1=yes)
    inputBinding:
      position: 101
      prefix: --deneutralloss
  - id: diagnostic_fragments
    type:
      - 'null'
      - string
    doc: '[nglycan/labile search_mode only]. Specify diagnostic fragments of labile
      mods that appear in the low m/z region. Only used if diagnostic_intensity_filter
      > 0.'
    inputBinding:
      position: 101
      prefix: --diagnostic_fragments
  - id: diagnostic_intensity_filter
    type:
      - 'null'
      - int
    doc: '[nglycan/labile search_mode only]. Specify diagnostic fragments of labile
      mods that appear in the low m/z region. Only used if diagnostic_intensity_filter
      > 0.'
    inputBinding:
      position: 101
      prefix: --diagnostic_intensity_filter
  - id: digest_mass_range
    type:
      - 'null'
      - string
    default: 500.0 5000.0
    inputBinding:
      position: 101
      prefix: --digest_mass_range
  - id: digest_max_length
    type:
      - 'null'
      - int
    default: 50
    inputBinding:
      position: 101
      prefix: --digest_max_length
  - id: digest_min_length
    type:
      - 'null'
      - int
    default: 7
    inputBinding:
      position: 101
      prefix: --digest_min_length
  - id: extension
    type:
      - 'null'
      - string
    doc: determine the input file extension (mzML, raw, RAW
    default: mzML
    inputBinding:
      position: 101
      prefix: --extension
  - id: fragment_ion_series
    type:
      - 'null'
      - string
    doc: Ion series used in search, specify any of a,b,c,x,y,z,b~,y~,Y,b-18,y-18
      (comma separated)
    default: b,y
    inputBinding:
      position: 101
      prefix: --fragment_ion_series
  - id: fragment_mass_tolerance
    type:
      - 'null'
      - float
    default: 20
    inputBinding:
      position: 101
      prefix: --fragment_mass_tolerance
  - id: fragment_mass_units
    type:
      - 'null'
      - int
    default: 1
    inputBinding:
      position: 101
      prefix: --fragment_mass_units
  - id: intensity_transform
    type:
      - 'null'
      - int
    doc: transform peaks intensities with sqrt root. 0 = not transform; 1 = 
      transform using sqrt root.
    inputBinding:
      position: 101
      prefix: --intensity_transform
  - id: ion_series_definitions
    type:
      - 'null'
      - string
    doc: 'User defined ion series. (Example: b* N -17.026548;b0 N -18.010565)'
    inputBinding:
      position: 101
      prefix: --ion_series_definitions
  - id: isotope_error
    type:
      - 'null'
      - string
    doc: 0=off, 0/1/2 (standard C13 error)
    default: 0/1/2
    inputBinding:
      position: 101
      prefix: --isotope_error
  - id: labile_search_mode
    type:
      - 'null'
      - string
    doc: type of search (nglycan, labile, or off). Off means non-labile/typical 
      search.
    default: off
    inputBinding:
      position: 101
      prefix: --labile_search_mode
  - id: localize_delta_mass
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --localize_delta_mass
  - id: mass_diff_to_variable_mod
    type:
      - 'null'
      - int
    doc: Put mass diff as a variable modification. 0 for no; 1 for yes and 
      change the original mass diff and the calculated mass accordingly; 2 for 
      yes but do not change the original mass diff.
    inputBinding:
      position: 101
      prefix: --mass_diff_to_variable_mod
  - id: mass_offsets
    type:
      - 'null'
      - string
    doc: allow for additional precursor mass window shifts
    inputBinding:
      position: 101
      prefix: --mass_offsets
  - id: max_fragment_charge
    type:
      - 'null'
      - int
    default: 2
    inputBinding:
      position: 101
      prefix: --max_fragment_charge
  - id: max_variable_mods_combinations
    type:
      - 'null'
      - int
    doc: maximum of 65534, limits number of modified peptides generated from 
      sequence
    default: 5000
    inputBinding:
      position: 101
      prefix: --max_variable_mods_combinations
  - id: max_variable_mods_per_peptide
    type:
      - 'null'
      - int
    doc: maximun of 5
    default: 3
    inputBinding:
      position: 101
      prefix: --max_variable_mods_per_peptide
  - id: memory
    type:
      - 'null'
      - int
    default: 8
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_fragments_modelling
    type:
      - 'null'
      - int
    default: 2
    inputBinding:
      position: 101
      prefix: --min_fragments_modelling
  - id: min_matched_fragments
    type:
      - 'null'
      - int
    default: 4
    inputBinding:
      position: 101
      prefix: --min_matched_fragments
  - id: minimum_peaks
    type:
      - 'null'
      - int
    doc: required minimum number of peaks in spectrum to search
    default: 15
    inputBinding:
      position: 101
      prefix: --minimum_peaks
  - id: minimum_ratio
    type:
      - 'null'
      - float
    default: 0.01
    inputBinding:
      position: 101
      prefix: --minimum_ratio
  - id: num_enzyme_termini
    type:
      - 'null'
      - int
    doc: 2 for enzymatic, 1 for semi-enzymatic, 0 for nonspecific digestion
    default: 2
    inputBinding:
      position: 101
      prefix: --num_enzyme_termini
  - id: num_threads
    type:
      - 'null'
      - int
    doc: CPU to set num threads; else specify num threads directly (max 64)
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: output_format
    type:
      - 'null'
      - string
    default: pepXML
    inputBinding:
      position: 101
      prefix: --output_format
  - id: output_max_expect
    type:
      - 'null'
      - int
    default: 50
    inputBinding:
      position: 101
      prefix: --output_max_expect
  - id: output_report_topn
    type:
      - 'null'
      - int
    default: 1
    inputBinding:
      position: 101
      prefix: --output_report_topN
  - id: override_charge
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --override_charge
  - id: param
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --param
  - id: path
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --path
  - id: precursor_charge
    type:
      - 'null'
      - string
    doc: precursor charge range to analyze; does not override any existing 
      charge; 0 as 1st entry ignores parameter
    default: 1 4
    inputBinding:
      position: 101
      prefix: --precursor_charge
  - id: precursor_mass_lower
    type:
      - 'null'
      - int
    default: -20
    inputBinding:
      position: 101
      prefix: --precursor_mass_lower
  - id: precursor_mass_mode
    type:
      - 'null'
      - string
    default: selected
    inputBinding:
      position: 101
      prefix: --precursor_mass_mode
  - id: precursor_mass_units
    type:
      - 'null'
      - int
    doc: 0=Daltons, 1=ppm
    default: 1
    inputBinding:
      position: 101
      prefix: --precursor_mass_units
  - id: precursor_mass_upper
    type:
      - 'null'
      - int
    default: 20
    inputBinding:
      position: 101
      prefix: --precursor_mass_upper
  - id: precursor_true_tolerance
    type:
      - 'null'
      - int
    default: 20
    inputBinding:
      position: 101
      prefix: --precursor_true_tolerance
  - id: precursor_true_units
    type:
      - 'null'
      - int
    doc: 0=Daltons, 1=ppm
    default: 1
    inputBinding:
      position: 101
      prefix: --precursor_true_units
  - id: remove_precursor_peak
    type:
      - 'null'
      - int
    doc: remove precursor peaks from tandem mass spectra. 0=not remove; 1=remove
      the peak with precursor charge;
    inputBinding:
      position: 101
      prefix: --remove_precursor_peak
  - id: remove_precursor_range
    type:
      - 'null'
      - string
    doc: 'm/z range in removing precursor peaks. Unit: Da.'
    default: -1.5,1.5
    inputBinding:
      position: 101
      prefix: --remove_precursor_range
  - id: report_alternative_proteins
    type:
      - 'null'
      - int
    doc: 0=no, 1=yes
    inputBinding:
      position: 101
      prefix: --report_alternative_proteins
  - id: restrict_deltamass_to
    type:
      - 'null'
      - string
    doc: Specify amino acids on which delta masses (mass offsets or search 
      modifications) can occur. Allowed values are single letter codes (e.g. 
      ACD)
    default: all
    inputBinding:
      position: 101
      prefix: --restrict_deltamass_to
  - id: search_enzyme_cut_1
    type:
      - 'null'
      - string
    default: KR
    inputBinding:
      position: 101
      prefix: --search_enzyme_cut_1
  - id: search_enzyme_cut_2
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --search_enzyme_cut_2
  - id: search_enzyme_name_1
    type:
      - 'null'
      - string
    default: Trypsin
    inputBinding:
      position: 101
      prefix: --search_enzyme_name_1
  - id: search_enzyme_name_2
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --search_enzyme_name_2
  - id: search_enzyme_nocut_1
    type:
      - 'null'
      - string
    default: P
    inputBinding:
      position: 101
      prefix: --search_enzyme_nocut_1
  - id: search_enzyme_nocut_2
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --search_enzyme_nocut_2
  - id: search_enzyme_sense_1
    type:
      - 'null'
      - string
    default: C
    inputBinding:
      position: 101
      prefix: --search_enzyme_sense_1
  - id: search_enzyme_sense_2
    type:
      - 'null'
      - string
    default: C
    inputBinding:
      position: 101
      prefix: --search_enzyme_sense_2
  - id: track_zero_topn
    type:
      - 'null'
      - int
    doc: in addition to topN results, keep track of top results in zero bin
    inputBinding:
      position: 101
      prefix: --track_zero_topN
  - id: use_all_mods_in_first_search
    type:
      - 'null'
      - int
    doc: Use all variable modifications in first search (0 for No, 1 for Yes)
    inputBinding:
      position: 101
      prefix: --use_all_mods_in_first_search
  - id: use_topn_peaks
    type:
      - 'null'
      - int
    default: 150
    inputBinding:
      position: 101
      prefix: --use_topN_peaks
  - id: variable_mod_01
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variable_mod_01
  - id: variable_mod_02
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variable_mod_02
  - id: variable_mod_03
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variable_mod_03
  - id: variable_mod_04
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variable_mod_04
  - id: variable_mod_05
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variable_mod_05
  - id: variable_mod_06
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variable_mod_06
  - id: variable_mod_07
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variable_mod_07
  - id: write_calibrated_mgf
    type:
      - 'null'
      - int
    doc: write calibrated MS2 scan to a MGF file (0 for No, 1 for Yes)
    inputBinding:
      position: 101
      prefix: --write_calibrated_mgf
  - id: y_type_masses
    type:
      - 'null'
      - string
    doc: "[nglycan/labile search_mode only]. Specify fragments of labile mods that
      are commonly retained on intact peptides (e.g. Y ions for glycans). Only used
      if 'Y' is included in fragment_ion_series."
    inputBinding:
      position: 101
      prefix: --Y_type_masses
  - id: zero_bin_accept_expect
    type:
      - 'null'
      - int
    doc: boost top zero bin entry to top if it has expect under 0.01 - set to 0 
      to disable
    inputBinding:
      position: 101
      prefix: --zero_bin_accept_expect
  - id: zero_bin_mult_expect
    type:
      - 'null'
      - int
    doc: disabled if above passes - multiply expect of zero bin for ordering 
      purposes (does not affect reported expect)
    default: 1
    inputBinding:
      position: 101
      prefix: --zero_bin_mult_expect
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_msfragger.out
