cwlVersion: v1.2
class: CommandLineTool
baseCommand: [searchgui, eu.isas.searchgui.cmd.IdentificationParametersCLI]
label: searchgui_identification_parameters_cli
doc: "IdentificationParametersCLI creates an identification parameters file.\n\nTool homepage: https://github.com/compomics/searchgui"
inputs:
  - id: out
    type: string
    doc: "The destination Identification Parameters file (.par). (Mandatory)"
    inputBinding:
      position: 1
      prefix: -out
  - id: id_params
    type: ['null', File]
    doc: "The identification parameters file to use. (Optional)"
    inputBinding:
      position: 1
      prefix: -id_params
  - id: prec_tol
    type: ['null', string]
    doc: "Precursor ion mass tolerance, default is '10'."
    inputBinding:
      position: 1
      prefix: -prec_tol
  - id: prec_ppm
    type: ['null', string]
    doc: "Precursor ion tolerance unit: ppm (1) or Da (0), default is '1'."
    inputBinding:
      position: 1
      prefix: -prec_ppm
  - id: frag_tol
    type: ['null', string]
    doc: "Fragment ion mass tolerance, default is '0.5'."
    inputBinding:
      position: 1
      prefix: -frag_tol
  - id: frag_ppm
    type: ['null', string]
    doc: "Fragment ion tolerance unit: ppm (1) or Da (0), default is '1'."
    inputBinding:
      position: 1
      prefix: -frag_ppm
  - id: digestion
    type: ['null', string]
    doc: "The type of digestion to consider: 0: Enzyme, 1: Unspecific, 2: Whole Protein. Default is 0."
    inputBinding:
      position: 1
      prefix: -digestion
  - id: enzyme
    type: ['null', string]
    doc: "Enzyme used, default is 'Trypsin'. If more than one enzyme was used, please provide them as comma separated list with quotes, e.g. \"Trypsin, Glu-C\". See EnzymesCLI to list and edit the enzymes."
    inputBinding:
      position: 1
      prefix: -enzyme
  - id: specificity
    type: ['null', string]
    doc: "Specificity of the enzyme.0: Specific, 1: Semi-Specific, 2: N-term Specific, 3: C-term Specific. If more than one enzyme was used, please provide the missed cleavages for every enzyme in the same order as comma separated list with quotes, e.g. \"0, 1\"."
    inputBinding:
      position: 1
      prefix: -specificity
  - id: fixed_mods
    type: ['null', string]
    doc: "Fixed modifications as comma separated list, e.g., \"Oxidation of M, Phosphorylation of S\""
    inputBinding:
      position: 1
      prefix: -fixed_mods
  - id: variable_mods
    type: ['null', string]
    doc: "Variable modifications as comma separated list, e.g., \"Oxidation of M, Phosphorylation of S\". See ModificationsCLI to list and edit the enzymes"
    inputBinding:
      position: 1
      prefix: -variable_mods
  - id: min_charge
    type: ['null', string]
    doc: "Minimal charge to search for, default is '2'."
    inputBinding:
      position: 1
      prefix: -min_charge
  - id: max_charge
    type: ['null', string]
    doc: "Maximal charge to search for, default is '4'."
    inputBinding:
      position: 1
      prefix: -max_charge
  - id: mc
    type: ['null', string]
    doc: "Number of allowed missed cleavages, default is '2'. If more than one enzyme was used, please provide the missed cleavages for every enzyme in the same order as comma separated list with quotes, e.g. \"2, 1\"."
    inputBinding:
      position: 1
      prefix: -mc
  - id: fi
    type: ['null', string]
    doc: "Type of forward ion searched, default is 'b'. If more than one ion should be used, please provide them as comma separated list with quotes, e.g. \"a, b\"."
    inputBinding:
      position: 1
      prefix: -fi
  - id: ri
    type: ['null', string]
    doc: "Type of rewind ion searched, default is 'y'. If more than one ion should be used, please provide them as comma separated list with quotes, e.g. \"y, z\"."
    inputBinding:
      position: 1
      prefix: -ri
  - id: min_isotope
    type: ['null', string]
    doc: "Minimal precursor isotope, default is '0'."
    inputBinding:
      position: 1
      prefix: -min_isotope
  - id: max_isotope
    type: ['null', string]
    doc: "Maximal precursor isotope, default is '1'."
    inputBinding:
      position: 1
      prefix: -max_isotope
  - id: xtandem_dynamic_range
    type: ['null', string]
    doc: "X!Tandem 'spectrum, dynamic range' option, default is '100'."
    inputBinding:
      position: 1
      prefix: -xtandem_dynamic_range
  - id: xtandem_npeaks
    type: ['null', string]
    doc: "X!Tandem 'spectrum, total peaks' option, default is '50'."
    inputBinding:
      position: 1
      prefix: -xtandem_npeaks
  - id: xtandem_min_frag_mz
    type: ['null', string]
    doc: "X!Tandem 'spectrum, minimum fragment mz' option, default is '200'."
    inputBinding:
      position: 1
      prefix: -xtandem_min_frag_mz
  - id: xtandem_min_peaks
    type: ['null', string]
    doc: "X!Tandem 'spectrum, minimum peaks' option, default is '5'."
    inputBinding:
      position: 1
      prefix: -xtandem_min_peaks
  - id: xtandem_noise_suppr
    type: ['null', string]
    doc: "X!Tandem 'spectrum, use noise suppression' option. 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -xtandem_noise_suppr
  - id: xtandem_min_prec_mass
    type: ['null', string]
    doc: "X!Tandem 'spectrum, minimum parent m+h' option, default is '500'."
    inputBinding:
      position: 1
      prefix: -xtandem_min_prec_mass
  - id: xtandem_parent_isotope_correction
    type: ['null', string]
    doc: "X!Tandem 'spectrum, parent monoisotopic mass isotope error. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_parent_isotope_correction
  - id: xtandem_quick_acetyl
    type: ['null', string]
    doc: "X!Tandem 'protein, quick acetyl' option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_quick_acetyl
  - id: xtandem_quick_pyro
    type: ['null', string]
    doc: "X!Tandem 'protein, quick pyrolidone' option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_quick_pyro
  - id: xtandem_stp_bias
    type: ['null', string]
    doc: "X!Tandem 'protein, stP bias' option. 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -xtandem_stp_bias
  - id: xtandem_ptm_complexity
    type: ['null', string]
    doc: "X!Tandem 'protein, ptm complexity' option, default is '6.0'."
    inputBinding:
      position: 1
      prefix: -xtandem_ptm_complexity
  - id: xtandem_refine
    type: ['null', string]
    doc: "X!Tandem 'refine' option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_refine
  - id: xtandem_refine_evalue
    type: ['null', string]
    doc: "X!Tandem 'refine, maximum valid expectation value' option, default is '0.01'."
    inputBinding:
      position: 1
      prefix: -xtandem_refine_evalue
  - id: xtandem_refine_unc
    type: ['null', string]
    doc: "X!Tandem 'refine, unanticipated cleavage' option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_refine_unc
  - id: xtandem_refine_semi
    type: ['null', string]
    doc: "X!Tandem 'refine, cleavage semi' option. 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -xtandem_refine_semi
  - id: xtandem_refine_pot
    type: ['null', string]
    doc: "X!Tandem 'refine, use potential modifications for full refinement' option. 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -xtandem_refine_pot
  - id: xtandem_refine_p_mut
    type: ['null', string]
    doc: "X!Tandem 'refine, point mutations' option. 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -xtandem_refine_p_mut
  - id: xtandem_refine_snaps
    type: ['null', string]
    doc: "X!Tandem 'refine, sNAps' option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_refine_snaps
  - id: xtandem_refine_spec_synt
    type: ['null', string]
    doc: "X!Tandem 'refine, spectrum synthesis' option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_refine_spec_synt
  - id: xtandem_evalue
    type: ['null', string]
    doc: "X!Tandem 'output, maximum valid expectation value' option, default is '0.01'."
    inputBinding:
      position: 1
      prefix: -xtandem_evalue
  - id: xtandem_output_results
    type: ['null', string]
    doc: "X!Tandem 'output, results' option (all|valid|stochastic), default is 'all'."
    inputBinding:
      position: 1
      prefix: -xtandem_output_results
  - id: xtandem_output_proteins
    type: ['null', string]
    doc: "X!Tandem 'output, proteins' option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_output_proteins
  - id: xtandem_output_sequences
    type: ['null', string]
    doc: "X!Tandem 'output, sequences' option. 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -xtandem_output_sequences
  - id: xtandem_output_spectra
    type: ['null', string]
    doc: "X!Tandem 'output, spectra' option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -xtandem_output_spectra
  - id: xtandem_output_histograms
    type: ['null', string]
    doc: "X!Tandem 'output, histograms' option. 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -xtandem_output_histograms
  - id: xtandem_skyline_path
    type: ['null', string]
    doc: "X!Tandem 'spectrum, skyline path' option."
    inputBinding:
      position: 1
      prefix: -xtandem_skyline_path
  - id: myrimatch_min_pep_length
    type: ['null', string]
    doc: "MyriMatch minumum peptide length, default is '6'."
    inputBinding:
      position: 1
      prefix: -myrimatch_min_pep_length
  - id: myrimatch_max_pep_length
    type: ['null', string]
    doc: "MyriMatch maximum peptide length, default is '30'."
    inputBinding:
      position: 1
      prefix: -myrimatch_max_pep_length
  - id: myrimatch_min_prec_mass
    type: ['null', string]
    doc: "MyriMatch minumum precursor mass, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -myrimatch_min_prec_mass
  - id: myrimatch_max_prec_mass
    type: ['null', string]
    doc: "MyriMatch maximum precursor mass, default is '10000.0'."
    inputBinding:
      position: 1
      prefix: -myrimatch_max_prec_mass
  - id: myrimatch_num_matches
    type: ['null', string]
    doc: "MyriMatch maximum number of spectrum matches, default is '10'."
    inputBinding:
      position: 1
      prefix: -myrimatch_num_matches
  - id: myrimatch_num_ptms
    type: ['null', string]
    doc: "MyriMatch max number of PTMs per peptide, default is '2'."
    inputBinding:
      position: 1
      prefix: -myrimatch_num_ptms
  - id: myrimatch_fragmentation
    type: ['null', string]
    doc: "MyriMatch fragmentation method, cid (b, y, true), etd (c, z*) or manual (a comma-separated list of [abcxyz] or z* (z+1, true), e.g. manual:b,y,z)."
    inputBinding:
      position: 1
      prefix: -myrimatch_fragmentation
  - id: myrimatch_termini
    type: ['null', string]
    doc: "MyriMatch number of enzymatic termini, e.g. 0: non-tryptic, 1: semi-tryptic, 2: fully-tryptic, default is '2'."
    inputBinding:
      position: 1
      prefix: -myrimatch_termini
  - id: myrimatch_plus_three
    type: ['null', string]
    doc: "MyriMatch smart plus three option, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -myrimatch_plus_three
  - id: myrimatch_xcorr
    type: ['null', string]
    doc: "MyriMatch xcorr option, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -myrimatch_xcorr
  - id: myrimatch_tic_cutoff
    type: ['null', string]
    doc: "MyriMatch TIC cutoff percentage, default is '0.98'."
    inputBinding:
      position: 1
      prefix: -myrimatch_tic_cutoff
  - id: myrimatch_intensity_classes
    type: ['null', string]
    doc: "MyriMatch number of intensity classes, default is '3'."
    inputBinding:
      position: 1
      prefix: -myrimatch_intensity_classes
  - id: myrimatch_class_multiplier
    type: ['null', string]
    doc: "MyriMatch class multiplier option, default is '2'."
    inputBinding:
      position: 1
      prefix: -myrimatch_class_multiplier
  - id: myrimatch_num_batches
    type: ['null', string]
    doc: "MyriMatch number of batches option, default is '50'."
    inputBinding:
      position: 1
      prefix: -myrimatch_num_batches
  - id: myrimatch_max_peak
    type: ['null', string]
    doc: "MyriMatch max number of peaks option, default is '100'."
    inputBinding:
      position: 1
      prefix: -myrimatch_max_peak
  - id: myrimatch_output
    type: ['null', string]
    doc: "MyriMatch output format option, mzIdentML or pepXML, default is 'mzIdentML'."
    inputBinding:
      position: 1
      prefix: -myrimatch_output
  - id: ms_amanda_decoy
    type: ['null', string]
    doc: "MS Amanda generate decoys option, 0: false, 1: true, default is '0'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_decoy
  - id: ms_amanda_decoy_ranking
    type: ['null', string]
    doc: "MS Amanda decoys ranking options, 0: shared rank, 1: rank target and decoy separately, default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_decoy_ranking
  - id: ms_amanda_instrument
    type: ['null', string]
    doc: "MS Amanda instrument id option. Available enzymes are listed in the GUI. (Note: case sensitive.)."
    inputBinding:
      position: 1
      prefix: -ms_amanda_instrument
  - id: ms_amanda_max_rank
    type: ['null', string]
    doc: "MS Amanda maximum rank, default is '10'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_rank
  - id: ms_amanda_mono
    type: ['null', string]
    doc: "MS Amanda use monoisotopic mass values, 0: false, 1: true, default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_mono
  - id: ms_amanda_perform_deisotoping
    type: ['null', string]
    doc: "MS Amanda perform deisotoping, 0: false, 1: true, default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_perform_deisotoping
  - id: ms_amanda_max_mod
    type: ['null', string]
    doc: "MS Amanda maximum number of occurrences of a specific modification on a peptide (0-10), default is '3'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_mod
  - id: ms_amanda_max_var_mod
    type: ['null', string]
    doc: "MS Amanda maximum number of variable modifications per peptide (0-10), default is '4'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_var_mod
  - id: ms_amanda_max_mod_sites
    type: ['null', string]
    doc: "MS Amanda maximum number of potential modification sites per modification per peptide (0-20), default is '6'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_mod_sites
  - id: ms_amanda_max_neutraul_losses
    type: ['null', string]
    doc: "MS Amanda maximum number of water and ammonia losses per peptide (0-5), default is '1'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_neutraul_losses
  - id: ms_amanda_max_neutral_losses_mod
    type: ['null', string]
    doc: "MS Amanda maximum number identical modification specific losses per peptide (0-5), default is '2'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_neutral_losses_mod
  - id: ms_amanda_min_pep_length
    type: ['null', string]
    doc: "MS Amanda minimum peptide length, default is '6'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_min_pep_length
  - id: ms_amanda_max_pep_length
    type: ['null', string]
    doc: "MS Amanda maximum peptide length, default is '30'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_pep_length
  - id: ms_amanda_loaded_proteins
    type: ['null', string]
    doc: "MS Amanda maximum number of proteins loaded into memory (1000-500000), default is '100000'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_loaded_proteins
  - id: ms_amanda_loaded_spectra
    type: ['null', string]
    doc: "MS Amanda maximum number of spectra loaded into memory (1000-500000), default is '2000'"
    inputBinding:
      position: 1
      prefix: -ms_amanda_loaded_spectra
  - id: ms_amanda_output
    type: ['null', string]
    doc: "MS Amanda output format option, csv or mzIdentML, default is 'csv'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_output
  - id: ms_amanda_max_charge_state
    type: ['null', string]
    doc: "MS Amanda maximum charge state of calculated fragment ions (+2, +3, +4, Precursor - 1), default is '+2'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_charge_state
  - id: ms_amanda_min_peak_depth
    type: ['null', string]
    doc: "MS Amanda minimum number of selected peaks within peak picking window (1-30), default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_min_peak_depth
  - id: ms_amanda_max_peak_depth
    type: ['null', string]
    doc: "MS Amanda maximum number of selected peaks within peak picking window (1-30), default is '10'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_peak_depth
  - id: ms_amanda_second_search
    type: ['null', string]
    doc: "MS Amanda perform second search to identify mixed spectrawindow, 0: false, 1: true, default is '0'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_second_search
  - id: ms_amanda_keep_y1
    type: ['null', string]
    doc: "MS Amanda whether y1 ion shall be kept for second search, 0: false, 1: true, default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_keep_y1
  - id: ms_amanda_remove_water_losses
    type: ['null', string]
    doc: "MS Amanda whether water losses shall be removed for second search, 0: false, 1: true, default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_remove_water_losses
  - id: ms_amanda_remove_ammonia_losses
    type: ['null', string]
    doc: "MS Amanda whether ammonia losses shall be removed for second search, 0: false, 1: true, default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_remove_ammonia_losses
  - id: ms_amanda_exclude_first_precusor
    type: ['null', string]
    doc: "MS Amanda exclude original precursor in second search, 0: false, 1: true, default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_exclude_first_precusor
  - id: ms_amanda_max_multiple_precursors
    type: ['null', string]
    doc: "MS Amanda maximum number of different precursors for second search (1-10), default is '5'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_max_multiple_precursors
  - id: ms_amanda_considered_charge_states
    type: ['null', string]
    doc: "MS Amanda charges to be tested for precursors (no deisotoping) where the charge cannot be defined (+2; +3; +2, +3; +2, +3, +4; +3, +4; +2, +3, +4, +5), default is '+2,+3'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_considered_charge_states
  - id: ms_amanda_combine_charge_states
    type: ['null', string]
    doc: "MS Amanda considered charges combined in one result, 0: false, 1: true, default is '1'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_combine_charge_states
  - id: ms_amanda_run_percolator
    type: ['null', string]
    doc: "MS Amanda automatically run percolator and add q-values to output file, 0: false, 1: true, default is '0'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_run_percolator
  - id: ms_amanda_pin_file
    type: ['null', string]
    doc: "MS Amanda Generate file for percolator; filename is the same as stated in output filename with suffix _pin.tsv., 0: false, 1: true, default is '0'."
    inputBinding:
      position: 1
      prefix: -ms_amanda_pin_file
  - id: msgf_decoy
    type: ['null', string]
    doc: "MS-GF+ search decoys option, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -msgf_decoy
  - id: msgf_instrument
    type: ['null', string]
    doc: "MS-GF+ instrument id option, 0: Low-res LCQ/LTQ, 1: Orbitrap/FTICR, 2: TOF, 3: Q-Exactive (Default)."
    inputBinding:
      position: 1
      prefix: -msgf_instrument
  - id: msgf_fragmentation
    type: ['null', string]
    doc: "MS-GF+ fragmentation id option, 0: Automatic: as written in the spectrum or CID if no info, 1: CID, 2: ETD, 3: HCD (Default). 4: UVPD."
    inputBinding:
      position: 1
      prefix: -msgf_fragmentation
  - id: msgf_protocol
    type: ['null', string]
    doc: "MS-GF+ protocol id option, 0: Automatic (Default, true), 1: Phosphorylation, 2: iTRAQ, 3: iTRAQPhospho, 4: TMT, 5: Standard."
    inputBinding:
      position: 1
      prefix: -msgf_protocol
  - id: msgf_termini
    type: ['null', string]
    doc: "MS-GF+ number of tolerable termini, e.g. 0: Non required, 1: At least one, 2: Both, default is '2'."
    inputBinding:
      position: 1
      prefix: -msgf_termini
  - id: msgf_min_pep_length
    type: ['null', string]
    doc: "MS-GF+ minumum peptide length, default is '8'."
    inputBinding:
      position: 1
      prefix: -msgf_min_pep_length
  - id: msgf_max_pep_length
    type: ['null', string]
    doc: "MS-GF+ maximum peptide length, default is '30'."
    inputBinding:
      position: 1
      prefix: -msgf_max_pep_length
  - id: msgf_num_ptms
    type: ['null', string]
    doc: "MS-GF+ max number of PTMs per peptide, default is '2'."
    inputBinding:
      position: 1
      prefix: -msgf_num_ptms
  - id: msgf_num_matches
    type: ['null', string]
    doc: "MS-GF+ maximum number of spectrum matches, default is '10'."
    inputBinding:
      position: 1
      prefix: -msgf_num_matches
  - id: msgf_additional
    type: ['null', string]
    doc: "MS-GF+ additional output, 0: output basic scores only (Default, true), 1: output additional features."
    inputBinding:
      position: 1
      prefix: -msgf_additional
  - id: msgf_num_tasks
    type: ['null', string]
    doc: "MS-GF+ number of tasks as an integer, default: internally calculated based on inputs"
    inputBinding:
      position: 1
      prefix: -msgf_num_tasks
  - id: omssa_low_intensity
    type: ['null', string]
    doc: "OMSSA low intensity cutoff as percentage of the most intense peak, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -omssa_low_intensity
  - id: omssa_high_intensity
    type: ['null', string]
    doc: "OMSSA high intensity cutoff as percentage of the most intense peak, default is '0.2'."
    inputBinding:
      position: 1
      prefix: -omssa_high_intensity
  - id: omssa_intensity_incr
    type: ['null', string]
    doc: "OMSSA intensity cutoff increment, default is '0.0005'."
    inputBinding:
      position: 1
      prefix: -omssa_intensity_incr
  - id: omssa_min_peaks
    type: ['null', string]
    doc: "OMSSA minimum number of peaks, integer, default is '4'."
    inputBinding:
      position: 1
      prefix: -omssa_min_peaks
  - id: omssa_remove_prec
    type: ['null', string]
    doc: "OMSSA eliminate charge reduced precursors in spectra option, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -omssa_remove_prec
  - id: omssa_estimate_charge
    type: ['null', string]
    doc: "OMSSA estimate precursor charge option, 1: Use range, 0: Believe input file, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_estimate_charge
  - id: omssa_plus_one
    type: ['null', string]
    doc: "OMSSA estimate plus one charge algorithmically option, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_plus_one
  - id: omssa_fraction
    type: ['null', string]
    doc: "OMSSA fraction of precursor m/z for charge charge one estimation, default is '0.95'."
    inputBinding:
      position: 1
      prefix: -omssa_fraction
  - id: omssa_prec_per_spectrum
    type: ['null', string]
    doc: "OMSSA minimum number of precursors per spectrum, integer, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_prec_per_spectrum
  - id: omssa_scale_prec
    type: ['null', string]
    doc: "OMSSA scale precursor mass option, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_scale_prec
  - id: omssa_memory
    type: ['null', string]
    doc: "OMSSA map sequences in memory option, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_memory
  - id: omssa_methionine
    type: ['null', string]
    doc: "OMSSA N-terminal methionine cleavage option, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_methionine
  - id: omssa_neutron
    type: ['null', string]
    doc: "Mass after which OMSSA should consider neutron exact mass, default is '1446.94'."
    inputBinding:
      position: 1
      prefix: -omssa_neutron
  - id: omssa_single_window_wd
    type: ['null', string]
    doc: "OMSSA single charge window width in Da, integer, default is '27'."
    inputBinding:
      position: 1
      prefix: -omssa_single_window_wd
  - id: omssa_double_window_wd
    type: ['null', string]
    doc: "OMSSA double charge window width in Da, integer, default is '14'."
    inputBinding:
      position: 1
      prefix: -omssa_double_window_wd
  - id: omssa_single_window_pk
    type: ['null', string]
    doc: "OMSSA single charge window number of peaks, integer, default is '2'."
    inputBinding:
      position: 1
      prefix: -omssa_single_window_pk
  - id: omssa_double_window_pk
    type: ['null', string]
    doc: "OMSSA double charge window number of peaks, integer, default is '2'."
    inputBinding:
      position: 1
      prefix: -omssa_double_window_pk
  - id: omssa_min_ann_int_pks
    type: ['null', string]
    doc: "OMSSA minimum number of annotated peaks among the most intense ones, integer, default is '6'."
    inputBinding:
      position: 1
      prefix: -omssa_min_ann_int_pks
  - id: omssa_min_annotated_peaks
    type: ['null', string]
    doc: "OMSSA minimum number of annotated peaks, integer, default is '2'."
    inputBinding:
      position: 1
      prefix: -omssa_min_annotated_peaks
  - id: omssa_max_ladders
    type: ['null', string]
    doc: "OMSSA maximum number of m/z ladders, integer, default is '128'."
    inputBinding:
      position: 1
      prefix: -omssa_max_ladders
  - id: omssa_max_frag_charge
    type: ['null', string]
    doc: "OMSSA maximum fragment charge, integer, default is '2'."
    inputBinding:
      position: 1
      prefix: -omssa_max_frag_charge
  - id: omssa_charge
    type: ['null', string]
    doc: "OMSSA fragment charge option, 1: plus, 0: minus, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_charge
  - id: omssa_forward
    type: ['null', string]
    doc: "OMSSA include first forward ion (b1) in search, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -omssa_forward
  - id: omssa_rewind
    type: ['null', string]
    doc: "OMSSA search rewind (C-terminal) ions option, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_rewind
  - id: omssa_max_frag_series
    type: ['null', string]
    doc: "OMSSA maximum fragment per series option, integer, default is '100'."
    inputBinding:
      position: 1
      prefix: -omssa_max_frag_series
  - id: omssa_corr
    type: ['null', string]
    doc: "OMSSA use correlation correction score option, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -omssa_corr
  - id: omssa_consecutive_p
    type: ['null', string]
    doc: "OMSSA consecutive ion probability, default is '0.5'."
    inputBinding:
      position: 1
      prefix: -omssa_consecutive_p
  - id: omssa_hitlist_charge
    type: ['null', string]
    doc: "OMSSA number of hits per spectrum per charge, default is '30'."
    inputBinding:
      position: 1
      prefix: -omssa_hitlist_charge
  - id: omssa_it_sequence_evalue
    type: ['null', string]
    doc: "OMSSA e-value cutoff to consider a sequence in the iterative search 0.0 means all, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -omssa_it_sequence_evalue
  - id: omssa_it_spectrum_evalue
    type: ['null', string]
    doc: "OMSSA e-value cutoff to consider a spectrum in the iterative search 0.0 means all, default is '0.01'."
    inputBinding:
      position: 1
      prefix: -omssa_it_spectrum_evalue
  - id: omssa_it_replace_evalue
    type: ['null', string]
    doc: "OMSSA e-value cutoff to replace a hit in the iterative search 0.0 means keep best, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -omssa_it_replace_evalue
  - id: omssa_min_pep_length
    type: ['null', string]
    doc: "OMSSA minumum peptide length (semi-tryptic or no enzyme searches only)."
    inputBinding:
      position: 1
      prefix: -omssa_min_pep_length
  - id: omssa_max_pep_length
    type: ['null', string]
    doc: "OMSSA maximum peptide length (OMSSA semi-tryptic or no enzyme searches only)."
    inputBinding:
      position: 1
      prefix: -omssa_max_pep_length
  - id: omssa_max_evalue
    type: ['null', string]
    doc: "OMSSA maximal evalue considered, default is '100'."
    inputBinding:
      position: 1
      prefix: -omssa_max_evalue
  - id: omssa_hitlist_length
    type: ['null', string]
    doc: "OMSSA hitlist length, 0 means all, default is '10'."
    inputBinding:
      position: 1
      prefix: -omssa_hitlist_length
  - id: omssa_format
    type: ['null', string]
    doc: "OMSSA output format. 0: omx, 1: csv, 2: pepXML, default is 'omx'."
    inputBinding:
      position: 1
      prefix: -omssa_format
  - id: comet_min_peaks
    type: ['null', string]
    doc: "Comet min number of peaks for a spectrum, default is '10'."
    inputBinding:
      position: 1
      prefix: -comet_min_peaks
  - id: comet_min_peak_int
    type: ['null', string]
    doc: "Comet minimal peak intensity, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -comet_min_peak_int
  - id: comet_remove_prec
    type: ['null', string]
    doc: "Comet remove precursor peaks, 0: no, 1: yes, 2: yes + all charge reduced precursor peaks, 3: yes + precursor phosphate neutral loss peaks, default is '0'."
    inputBinding:
      position: 1
      prefix: -comet_remove_prec
  - id: comet_remove_prec_tol
    type: ['null', string]
    doc: "Comet remove precursor tolerance, default is '1.5'."
    inputBinding:
      position: 1
      prefix: -comet_remove_prec_tol
  - id: comet_clear_mz_range_lower
    type: ['null', string]
    doc: "Comet clear mz range lower, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -comet_clear_mz_range_lower
  - id: comet_clear_mz_range_upper
    type: ['null', string]
    doc: "Comet clear mz range upper, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -comet_clear_mz_range_upper
  - id: comet_enzyme_type
    type: ['null', string]
    doc: "Comet enzyme type, 1: semi-specific, 2: full-enzyme, 8: unspecific N-term, 9: unspecific C-term, default is '2'."
    inputBinding:
      position: 1
      prefix: -comet_enzyme_type
  - id: comet_isotope_correction
    type: ['null', string]
    doc: "Comet isotope correction, 0: no correction, 1: 0, +1, 2: 0, +1, +2, 3: 0,+1,+2,+3, 4: -8,-4,0,+4,+8, default is '1'."
    inputBinding:
      position: 1
      prefix: -comet_isotope_correction
  - id: comet_min_prec_mass
    type: ['null', string]
    doc: "Comet minimum precursor mass, default is '600.0'."
    inputBinding:
      position: 1
      prefix: -comet_min_prec_mass
  - id: comet_max_prec_mass
    type: ['null', string]
    doc: "Comet maximum precursor mass, default is '5000.0'."
    inputBinding:
      position: 1
      prefix: -comet_max_prec_mass
  - id: comet_min_pep_length
    type: ['null', string]
    doc: "Comet minimum peptide length, default is '8'."
    inputBinding:
      position: 1
      prefix: -comet_min_pep_length
  - id: comet_max_pep_length
    type: ['null', string]
    doc: "Comet maximum peptide length, default is '30'."
    inputBinding:
      position: 1
      prefix: -comet_max_pep_length
  - id: comet_max_frag_charge
    type: ['null', string]
    doc: "Comet maximum fragment charge [1-5], default is '3'."
    inputBinding:
      position: 1
      prefix: -comet_max_frag_charge
  - id: comet_remove_meth
    type: ['null', string]
    doc: "Comet remove methionine, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -comet_remove_meth
  - id: comet_batch_size
    type: ['null', string]
    doc: "Comet spectrum batch size, '0' means load and search all spectra at once, default is '0'."
    inputBinding:
      position: 1
      prefix: -comet_batch_size
  - id: comet_num_ptms
    type: ['null', string]
    doc: "Comet max number of variable PTMs per peptide, default is '10'."
    inputBinding:
      position: 1
      prefix: -comet_num_ptms
  - id: comet_req_ptms
    type: ['null', string]
    doc: "Comet require at least one variable PTM per peptide, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -comet_req_ptms
  - id: comet_theoretical_fragment_ions
    type: ['null', string]
    doc: "Comet theoretical_fragment_ions option, it is the correlation score type, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -comet_theoretical_fragment_ions
  - id: comet_frag_bin_offset
    type: ['null', string]
    doc: "Comet fragment bin offset, default is '0.01'."
    inputBinding:
      position: 1
      prefix: -comet_frag_bin_offset
  - id: comet_num_matches
    type: ['null', string]
    doc: "Comet maximum number of spectrum matches, default is '10'."
    inputBinding:
      position: 1
      prefix: -comet_num_matches
  - id: comet_output
    type: ['null', string]
    doc: "Comet output type, PepXML, SQT, TXT, Percolator or mzIdentML, default is 'PepXML'."
    inputBinding:
      position: 1
      prefix: -comet_output
  - id: tide_min_pep_length
    type: ['null', string]
    doc: "Tide minumum peptide length, default is '6'."
    inputBinding:
      position: 1
      prefix: -tide_min_pep_length
  - id: tide_max_pep_length
    type: ['null', string]
    doc: "Tide maximum peptide length, default is '30'."
    inputBinding:
      position: 1
      prefix: -tide_max_pep_length
  - id: tide_min_prec_mass
    type: ['null', string]
    doc: "Tide minumum precursor mass, default is '200.0'."
    inputBinding:
      position: 1
      prefix: -tide_min_prec_mass
  - id: tide_max_prec_mass
    type: ['null', string]
    doc: "Tide maximum precursor mass, default is '7200.0'."
    inputBinding:
      position: 1
      prefix: -tide_max_prec_mass
  - id: tide_monoisotopic
    type: ['null', string]
    doc: "Tide monoisotopic precursor, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -tide_monoisotopic
  - id: tide_clip_n_term
    type: ['null', string]
    doc: "Tide clip n term methionine, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_clip_n_term
  - id: tide_max_ptms
    type: ['null', string]
    doc: "Tide max number of PTMs per peptide, default is '255'."
    inputBinding:
      position: 1
      prefix: -tide_max_ptms
  - id: tide_num_ptms_per_type
    type: ['null', string]
    doc: "Tide max number of PTMs of each type per peptide, default is '2'."
    inputBinding:
      position: 1
      prefix: -tide_num_ptms_per_type
  - id: tide_digestion_type
    type: ['null', string]
    doc: "Tide digetion type (full-digest or partial-digest, true), default is 'full-digest'."
    inputBinding:
      position: 1
      prefix: -tide_digestion_type
  - id: tide_print_peptides
    type: ['null', string]
    doc: "Tide print peptides, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_print_peptides
  - id: tide_decoy_format
    type: ['null', string]
    doc: "Tide decoy fomat (none|shuffle|peptide-reverse|protein-reverse, true), default is 'none'."
    inputBinding:
      position: 1
      prefix: -tide_decoy_format
  - id: tide_keep_terminals
    type: ['null', string]
    doc: "Tide keep terminal amino acids when creating decoys (N|C|NC|none, true), default is 'NC'."
    inputBinding:
      position: 1
      prefix: -tide_keep_terminals
  - id: tide_decoy_seed
    type: ['null', string]
    doc: "Tide decoy seed, default is '1'."
    inputBinding:
      position: 1
      prefix: -tide_decoy_seed
  - id: tide_remove_temp
    type: ['null', string]
    doc: "Tide remove temp folders when the search is done, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -tide_remove_temp
  - id: tide_compute_p
    type: ['null', string]
    doc: "Tide compute exact p-values, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_compute_p
  - id: tide_compute_sp
    type: ['null', string]
    doc: "Tide compute sp score, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_compute_sp
  - id: tide_min_spectrum_mz
    type: ['null', string]
    doc: "Tide minimum spectrum mz, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -tide_min_spectrum_mz
  - id: tide_max_spectrum_mz
    type: ['null', string]
    doc: "Tide maximum spectrum mz, default is no limit."
    inputBinding:
      position: 1
      prefix: -tide_max_spectrum_mz
  - id: tide_min_spectrum_peaks
    type: ['null', string]
    doc: "Tide min spectrum peaks, default is '20'."
    inputBinding:
      position: 1
      prefix: -tide_min_spectrum_peaks
  - id: tide_remove_prec
    type: ['null', string]
    doc: "Tide remove precursor, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_remove_prec
  - id: tide_remove_prec_tol
    type: ['null', string]
    doc: "Tide remove precursor tolerance, default is '1.5'."
    inputBinding:
      position: 1
      prefix: -tide_remove_prec_tol
  - id: tide_use_flanking
    type: ['null', string]
    doc: "Tide use flanking peaks, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_use_flanking
  - id: tide_use_neutral_losses
    type: ['null', string]
    doc: "Tide use neutral losses peaks, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_use_neutral_losses
  - id: tide_mz_bin_width
    type: ['null', string]
    doc: "Tide mz bin width, default is '0.02'."
    inputBinding:
      position: 1
      prefix: -tide_mz_bin_width
  - id: tide_mz_bin_offset
    type: ['null', string]
    doc: "Tide mz bin offset, default is '0.0'."
    inputBinding:
      position: 1
      prefix: -tide_mz_bin_offset
  - id: tide_max_psms
    type: ['null', string]
    doc: "Tide maximum number of spectrum matches spectrum, default is '10'."
    inputBinding:
      position: 1
      prefix: -tide_max_psms
  - id: tide_export_text
    type: ['null', string]
    doc: "Tide export text file, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -tide_export_text
  - id: tide_export_sqt
    type: ['null', string]
    doc: "Tide export SQT file, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_export_sqt
  - id: tide_export_pepxml
    type: ['null', string]
    doc: "Tide export pepxml, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_export_pepxml
  - id: tide_export_mzid
    type: ['null', string]
    doc: "Tide export mzid, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_export_mzid
  - id: tide_export_pin
    type: ['null', string]
    doc: "Tide export Percolator input file, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_export_pin
  - id: tide_output_folder
    type: ['null', string]
    doc: "Tide output folder (relative to the Tide working folder, true), default is 'crux-output'."
    inputBinding:
      position: 1
      prefix: -tide_output_folder
  - id: tide_verbosity
    type: ['null', string]
    doc: "Tide progress display verbosity (0|10|20|30|40|50|60, true), default is '30'."
    inputBinding:
      position: 1
      prefix: -tide_verbosity
  - id: tide_progress_indicator
    type: ['null', string]
    doc: "Tide progress indicator frequency, default is '1000'."
    inputBinding:
      position: 1
      prefix: -tide_progress_indicator
  - id: tide_concat
    type: ['null', string]
    doc: "Tide concatenate target and decoy results, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -tide_concat
  - id: tide_store_spectra
    type: ['null', string]
    doc: "Tide file name in with to store the binary spectra, default is null, i.e., not set."
    inputBinding:
      position: 1
      prefix: -tide_store_spectra
  - id: andromeda_max_pep_mass
    type: ['null', string]
    doc: "Andromeda maximum peptide mass, default is '4600.0'."
    inputBinding:
      position: 1
      prefix: -andromeda_max_pep_mass
  - id: andromeda_max_comb
    type: ['null', string]
    doc: "Andromeda maximum combinations, default is '250'."
    inputBinding:
      position: 1
      prefix: -andromeda_max_comb
  - id: andromeda_top_peaks
    type: ['null', string]
    doc: "Andromeda number of top peaks, default is '8'."
    inputBinding:
      position: 1
      prefix: -andromeda_top_peaks
  - id: andromeda_top_peaks_window
    type: ['null', string]
    doc: "Andromeda top peaks window width, default is '100'."
    inputBinding:
      position: 1
      prefix: -andromeda_top_peaks_window
  - id: andromeda_incl_water
    type: ['null', string]
    doc: "Andromeda account for water losses, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -andromeda_incl_water
  - id: andromeda_incl_ammonia
    type: ['null', string]
    doc: "Andromeda account for ammonina losses, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -andromeda_incl_ammonia
  - id: andromeda_neutral_losses
    type: ['null', string]
    doc: "Andromeda neutral losses are sequence dependent, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -andromeda_neutral_losses
  - id: andromeda_fragment_all
    type: ['null', string]
    doc: "Andromeda fragment all option, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -andromeda_fragment_all
  - id: andromeda_emp_correction
    type: ['null', string]
    doc: "Andromeda emperical correction, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -andromeda_emp_correction
  - id: andromeda_higher_charge
    type: ['null', string]
    doc: "Andromeda higher charge option, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -andromeda_higher_charge
  - id: andromeda_frag_method
    type: ['null', string]
    doc: "Andromeda fragmentation method, HCD, CID or EDT, default is 'CID'."
    inputBinding:
      position: 1
      prefix: -andromeda_frag_method
  - id: andromeda_max_mods
    type: ['null', string]
    doc: "Andromeda maximum number of modifications, default is '5'."
    inputBinding:
      position: 1
      prefix: -andromeda_max_mods
  - id: andromeda_min_pep_length
    type: ['null', string]
    doc: "Andromeda minimum peptide length when using no enzyme, default is '8'."
    inputBinding:
      position: 1
      prefix: -andromeda_min_pep_length
  - id: andromeda_max_pep_length
    type: ['null', string]
    doc: "Andromeda maximum peptide length when using no enzyme, default is '30'."
    inputBinding:
      position: 1
      prefix: -andromeda_max_pep_length
  - id: andromeda_equal_il
    type: ['null', string]
    doc: "Andromeda whether I and L should be considered indistinguishable, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -andromeda_equal_il
  - id: andromeda_max_psms
    type: ['null', string]
    doc: "Andromeda maximum number of spectrum matches spectrum, default is '10'."
    inputBinding:
      position: 1
      prefix: -andromeda_max_psms
  - id: andromeda_decoy_mode
    type: ['null', string]
    doc: "Andromeda decoy mode, none or decoy, default is 'none'."
    inputBinding:
      position: 1
      prefix: -andromeda_decoy_mode
  - id: meta_morpheus_min_pep_length
    type: ['null', string]
    doc: "MetaMorpheus minimum peptide length, default is '8'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_min_pep_length
  - id: meta_morpheus_max_pep_length
    type: ['null', string]
    doc: "MetaMorpheus maximum peptide length, default is '30'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_max_pep_length
  - id: meta_morpheus_search_type
    type: ['null', string]
    doc: "MetaMorpheus search type, Classic, Modern or NonSpecific, default is 'Classic'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_search_type
  - id: meta_morpheus_num_partitions
    type: ['null', string]
    doc: "MetaMorpheus number of partitions when indexing, default is '1'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_num_partitions
  - id: meta_morpheus_dissociation_type
    type: ['null', string]
    doc: "MetaMorpheus dissociation type, HCD, CID, ECD or ETD, default is 'HCD'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_dissociation_type
  - id: meta_morpheus_max_mods_for_peptide
    type: ['null', string]
    doc: "MetaMorpheus maximum modifications per peptide, default is '2'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_max_mods_for_peptide
  - id: meta_morpheus_meth
    type: ['null', string]
    doc: "MetaMorpheus initiator methionine behavior, Undefined, Retain, Cleave or Variable, default is 'Variable'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_meth
  - id: meta_morpheus_score_cutoff
    type: ['null', string]
    doc: "MetaMorpheus score cutoff, default is '5.0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_score_cutoff
  - id: meta_morpheus_use_delta_score
    type: ['null', string]
    doc: "MetaMorpheus use delta score, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_use_delta_score
  - id: meta_morpheus_frag_term
    type: ['null', string]
    doc: "MetaMorpheus fragmentation terminus, Both, N or C, default is 'Both'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_frag_term
  - id: meta_morpheus_max_frag_size
    type: ['null', string]
    doc: "MetaMorpheus maximum fragmentation size, default is '30000'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_max_frag_size
  - id: meta_morpheus_min_internal_fragment_length
    type: ['null', string]
    doc: "MetaMorpheus minimum allowed internal fragment length, default is '0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_min_internal_fragment_length
  - id: meta_morpheus_mass_diff_acceptor_type
    type: ['null', string]
    doc: "MetaMorpheus mass difference acceptor type: Exact, OneMM, TwoMM, ThreeMM, PlusOrMinusThreeMM, ModOpen or Open, default is 'OneMM'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_mass_diff_acceptor_type
  - id: meta_morpheus_write_mzid
    type: ['null', string]
    doc: "MetaMorpheus write mzid, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_write_mzid
  - id: meta_morpheus_write_pepxml
    type: ['null', string]
    doc: "MetaMorpheus write pepxml, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_write_pepxml
  - id: meta_morpheus_use_provided_prec
    type: ['null', string]
    doc: "MetaMorpheus use provided precursor info, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_use_provided_prec
  - id: meta_morpheus_do_prec_deconv
    type: ['null', string]
    doc: "MetaMorpheus do precursor deconvolution, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_do_prec_deconv
  - id: meta_morpheus_deconv_int_ratio
    type: ['null', string]
    doc: "MetaMorpheus deconvolution intensity ratio, default is '3.0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_deconv_int_ratio
  - id: meta_morpheus_deconv_mass_tol
    type: ['null', string]
    doc: "MetaMorpheus deoconvolution mass tolerance, default is '4.0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_deconv_mass_tol
  - id: meta_morpheus_deconv_mass_tol_type
    type: ['null', string]
    doc: "MetaMorpheus deoconvolution mass tolerance type, PPM or Absolute, default is 'PPM'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_deconv_mass_tol_type
  - id: meta_morpheus_trim_ms1
    type: ['null', string]
    doc: "MetaMorpheus trim MS1 peaks, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_trim_ms1
  - id: meta_morpheus_trim_msms
    type: ['null', string]
    doc: "MetaMorpheus trim MSMS peaks, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_trim_msms
  - id: meta_morpheus_num_peaks_per_window
    type: ['null', string]
    doc: "MetaMorpheus number of peaks per window, default is '200'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_num_peaks_per_window
  - id: meta_morpheus_min_allowed_int_ratio_to_base_peak
    type: ['null', string]
    doc: "MetaMorpheus minium allowed intensity ratio to base peak, default is '0.01'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_min_allowed_int_ratio_to_base_peak
  - id: meta_morpheus_window_with_thompson
    type: ['null', string]
    doc: "MetaMorpheus window width in Thompson."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_window_with_thompson
  - id: meta_morpheus_num_windows
    type: ['null', string]
    doc: "MetaMorpheus number of windows."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_num_windows
  - id: meta_morpheus_norm_across_all_windows
    type: ['null', string]
    doc: "MetaMorpheus normalize peaks across all windows, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_norm_across_all_windows
  - id: meta_morpheus_mod_peptides_are_different
    type: ['null', string]
    doc: "MetaMorpheus modified peptides are different, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_mod_peptides_are_different
  - id: meta_morpheus_no_one_hit_wonders
    type: ['null', string]
    doc: "MetaMorpheus exclude one hit wonders, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_no_one_hit_wonders
  - id: meta_morpheus_search_target
    type: ['null', string]
    doc: "MetaMorpheus search target sequences, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_search_target
  - id: meta_morpheus_decoy_type
    type: ['null', string]
    doc: "MetaMorpheus decoy type, None, Reverse or Slide, default is 'None'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_decoy_type
  - id: meta_morpheus_max_mod_isoforms
    type: ['null', string]
    doc: "MetaMorpheus maximum modified isoforms, default is '1024'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_max_mod_isoforms
  - id: meta_morpheus_min_variant_depth
    type: ['null', string]
    doc: "MetaMorpheus minimum variant depth, default is '1'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_min_variant_depth
  - id: meta_morpheus_max_hetrozygous_var
    type: ['null', string]
    doc: "MetaMorpheus maximum hetrozygous variants, default is '4'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_max_hetrozygous_var
  - id: meta_morpheus_gptm
    type: ['null', string]
    doc: "MetaMorpheus run G-PTM, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_gptm
  - id: meta_morpheus_gptm_categories
    type: ['null', string]
    doc: "MetaMorpheus G-PTM categories to include in the G-PTM search: Common Fixed and Variable, Common Biological, Common Artifact, Metal, Glycosylation, Less Common, Labeling, Substitution (1 Nucleotide), Substitution (2+ Nucleotides), Other."
    inputBinding:
      position: 1
      prefix: -meta_morpheus_gptm_categories
  - id: sage_bucket_size
    type: ['null', string]
    doc: "Sage bucket size, number of fragments in each internal mass bucket, default is '32768'."
    inputBinding:
      position: 1
      prefix: -sage_bucket_size
  - id: sage_min_pep_length
    type: ['null', string]
    doc: "Sage minimum peptide length, default is '8'."
    inputBinding:
      position: 1
      prefix: -sage_min_pep_length
  - id: sage_max_pep_length
    type: ['null', string]
    doc: "Sage maximum peptide length, default is '30'."
    inputBinding:
      position: 1
      prefix: -sage_max_pep_length
  - id: sage_min_frag_mz
    type: ['null', string]
    doc: "Sage minimum fragment mz, default is '200.0'."
    inputBinding:
      position: 1
      prefix: -sage_min_frag_mz
  - id: sage_max_frag_mz
    type: ['null', string]
    doc: "Sage maximum fragment mz, default is '2000.0'."
    inputBinding:
      position: 1
      prefix: -sage_max_frag_mz
  - id: sage_min_pep_mass
    type: ['null', string]
    doc: "Sage minimum peptide mass, default is '600.0'."
    inputBinding:
      position: 1
      prefix: -sage_min_pep_mass
  - id: sage_max_pep_mass
    type: ['null', string]
    doc: "Sage maximum peptide mass, default is '5000.0'."
    inputBinding:
      position: 1
      prefix: -sage_max_pep_mass
  - id: sage_min_ion_index
    type: ['null', string]
    doc: "Sage minimum ion index for the preliminary search, default is '2', i.e. skip b1/b2/y1/y2 ions."
    inputBinding:
      position: 1
      prefix: -sage_min_ion_index
  - id: sage_max_var_mods
    type: ['null', string]
    doc: "Sage maximum number of variable modifications, default is '2'."
    inputBinding:
      position: 1
      prefix: -sage_max_var_mods
  - id: sage_generate_decoys
    type: ['null', string]
    doc: "Sage generate decoys, default is 'true'."
    inputBinding:
      position: 1
      prefix: -sage_generate_decoys
  - id: sage_tmt
    type: ['null', string]
    doc: "Sage TMT: Tmt6, Tmt10, Tmt11, Tmt16, or Tmt18."
    inputBinding:
      position: 1
      prefix: -sage_tmt
  - id: sage_tmt_level
    type: ['null', string]
    doc: "Sage TMT level: MS-level to perform TMT quantification on, default is '3'."
    inputBinding:
      position: 1
      prefix: -sage_tmt_level
  - id: sage_tmt_sn
    type: ['null', string]
    doc: "Sage use signal/noise instead of intensity for TMT quant, default is 'false'."
    inputBinding:
      position: 1
      prefix: -sage_tmt_sn
  - id: sage_lfq
    type: ['null', string]
    doc: "Sage perform LFQ, default is 'false'."
    inputBinding:
      position: 1
      prefix: -sage_lfq
  - id: sage_lfq_peak_scoring
    type: ['null', string]
    doc: "Sage LFQ peak scoring: Hybrid, RetentionTime or SpectralAngle. Default is 'Hybrid'."
    inputBinding:
      position: 1
      prefix: -sage_lfq_peak_scoring
  - id: sage_lfq_intergration
    type: ['null', string]
    doc: "Sage LFQ integration: Sum or Max. Default is 'Sum'."
    inputBinding:
      position: 1
      prefix: -sage_lfq_intergration
  - id: sage_lfq_spectral_angle
    type: ['null', string]
    doc: "Sage LFQ spectral angle, default is '0.7'."
    inputBinding:
      position: 1
      prefix: -sage_lfq_spectral_angle
  - id: sage_deisotope
    type: ['null', string]
    doc: "Sage deisotope, perform deisotoping and charge state deconvolution, default is 'false'."
    inputBinding:
      position: 1
      prefix: -sage_deisotope
  - id: sage_chimera
    type: ['null', string]
    doc: "Sage search for chimeric/co-fragmenting PSMs, default is 'false'."
    inputBinding:
      position: 1
      prefix: -sage_chimera
  - id: sage_wide_window
    type: ['null', string]
    doc: "Sage ignore `precursor_tol` and search spectra in wide-window/dynamic precursor tolerance mode, default is 'false'."
    inputBinding:
      position: 1
      prefix: -sage_wide_window
  - id: sage_predict_rt
    type: ['null', string]
    doc: "Sage use of retention time prediction model as an feature for LDA, default is 'true'."
    inputBinding:
      position: 1
      prefix: -sage_predict_rt
  - id: sage_min_peaks
    type: ['null', string]
    doc: "Sage min number of peaks for a spectrum, default is '15'."
    inputBinding:
      position: 1
      prefix: -sage_min_peaks
  - id: sage_max_peaks
    type: ['null', string]
    doc: "Sage max number of peaks for a spectrum, default is '150'."
    inputBinding:
      position: 1
      prefix: -sage_max_peaks
  - id: sage_min_matched_peaks
    type: ['null', string]
    doc: "Sage minimum matched peaks, default is '4'."
    inputBinding:
      position: 1
      prefix: -sage_min_matched_peaks
  - id: sage_max_frag_charge
    type: ['null', string]
    doc: "Sage maximum fragment charge, default is 'null'."
    inputBinding:
      position: 1
      prefix: -sage_max_frag_charge
  - id: sage_num_psms
    type: ['null', string]
    doc: "Sage number of PSMs to report for each spectra. Recommend setting to 1, higher values might disrupt LDA, default is '1'."
    inputBinding:
      position: 1
      prefix: -sage_num_psms
  - id: sage_batch_size
    type: ['null', string]
    doc: "Sage batch size, default is the number of CPUs/2."
    inputBinding:
      position: 1
      prefix: -sage_batch_size
  - id: novor_fragmentation
    type: ['null', string]
    doc: "Novor fragmentation method, CID or HCD, default is 'HCD'."
    inputBinding:
      position: 1
      prefix: -novor_fragmentation
  - id: novor_mass_analyzer
    type: ['null', string]
    doc: "Novor mass analyzer, Trap, TOF, or FT, default is 'FT'."
    inputBinding:
      position: 1
      prefix: -novor_mass_analyzer
  - id: pnovo_activation
    type: ['null', string]
    doc: "pNovo+ activation type (HCD, CID or EDT, true), default is 'HCD'."
    inputBinding:
      position: 1
      prefix: -pnovo_activation
  - id: pnovo_lower_prec
    type: ['null', string]
    doc: "pNovo+ minimum precursor mass, default is '300'."
    inputBinding:
      position: 1
      prefix: -pnovo_lower_prec
  - id: pnovo_upper_prec
    type: ['null', string]
    doc: "pNovo+ maximum precursor mass, default is '5000'."
    inputBinding:
      position: 1
      prefix: -pnovo_upper_prec
  - id: pnovo_num_peptides
    type: ['null', string]
    doc: "pNovo+ number of peptides per spectrum, default is '10'."
    inputBinding:
      position: 1
      prefix: -pnovo_num_peptides
  - id: pepnovo_hitlist_length
    type: ['null', string]
    doc: "PepNovo+ number of de novo solutions [0-2000], default is '10'."
    inputBinding:
      position: 1
      prefix: -pepnovo_hitlist_length
  - id: pepnovo_estimate_charge
    type: ['null', string]
    doc: "PepNovo+ estimate precursor charge option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -pepnovo_estimate_charge
  - id: pepnovo_correct_prec_mass
    type: ['null', string]
    doc: "PepNovo+ correct precursor mass option. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -pepnovo_correct_prec_mass
  - id: pepnovo_discard_spectra
    type: ['null', string]
    doc: "PepNovo+ discard low quality spectra optoin. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -pepnovo_discard_spectra
  - id: pepnovo_generate_blast
    type: ['null', string]
    doc: "PepNovo+ generate a BLAST query. 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -pepnovo_generate_blast
  - id: directag_tag_length
    type: ['null', string]
    doc: "DirecTag tag length, default is '4'."
    inputBinding:
      position: 1
      prefix: -directag_tag_length
  - id: directag_max_var_mods
    type: ['null', string]
    doc: "DirecTag maximum variable modifications per sequence, default is '2'."
    inputBinding:
      position: 1
      prefix: -directag_max_var_mods
  - id: directag_charge_states
    type: ['null', string]
    doc: "DirecTag number of charge states considered, default is '3'."
    inputBinding:
      position: 1
      prefix: -directag_charge_states
  - id: directag_duplicate_spectra
    type: ['null', string]
    doc: "DirecTag duplicate spectra per charge, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -directag_duplicate_spectra
  - id: directag_isotope_tolerance
    type: ['null', string]
    doc: "DirecTag isotope mz tolerance, default is '0.25'."
    inputBinding:
      position: 1
      prefix: -directag_isotope_tolerance
  - id: directag_deisotoping
    type: ['null', string]
    doc: "DirecTag deisotoping mode, default is '0', 0: no deisotoping, 1: precursor only, 2: precursor and candidate."
    inputBinding:
      position: 1
      prefix: -directag_deisotoping
  - id: directag_intensity_classes
    type: ['null', string]
    doc: "DirecTag number of intensity classses, default is '3'."
    inputBinding:
      position: 1
      prefix: -directag_intensity_classes
  - id: directag_output_suffix
    type: ['null', string]
    doc: "DirecTag output suffic, default is no suffix."
    inputBinding:
      position: 1
      prefix: -directag_output_suffix
  - id: directag_max_peak_count
    type: ['null', string]
    doc: "DirecTag max peak count, default is '100'."
    inputBinding:
      position: 1
      prefix: -directag_max_peak_count
  - id: directag_max_tag_count
    type: ['null', string]
    doc: "DirecTag maximum tag count, default is '10'."
    inputBinding:
      position: 1
      prefix: -directag_max_tag_count
  - id: directag_tic_cutoff
    type: ['null', string]
    doc: "DirecTag TIC cutoff in percent, default is '100'."
    inputBinding:
      position: 1
      prefix: -directag_tic_cutoff
  - id: directag_complement_tolerance
    type: ['null', string]
    doc: "DirecTag complement mz tolerance, default is '0.1'."
    inputBinding:
      position: 1
      prefix: -directag_complement_tolerance
  - id: directag_adjustment_step
    type: ['null', string]
    doc: "DirecTag precursor adjustment step, default is '0.1'."
    inputBinding:
      position: 1
      prefix: -directag_adjustment_step
  - id: directag_min_adjustment
    type: ['null', string]
    doc: "DirecTag minimum precursor adjustment, default is '-0.5'."
    inputBinding:
      position: 1
      prefix: -directag_min_adjustment
  - id: directag_max_adjustment
    type: ['null', string]
    doc: "DirecTag maximum precursor adjustment, default is '1.5'."
    inputBinding:
      position: 1
      prefix: -directag_max_adjustment
  - id: directag_intensity_weight
    type: ['null', string]
    doc: "DirecTag intensity score weight, default is '1.0'."
    inputBinding:
      position: 1
      prefix: -directag_intensity_weight
  - id: directag_fidelity_weight
    type: ['null', string]
    doc: "DirecTag fidelity score weight, default is '1.0'."
    inputBinding:
      position: 1
      prefix: -directag_fidelity_weight
  - id: directag_complement_weight
    type: ['null', string]
    doc: "DirecTag complement_score_weight, default is '1.0'."
    inputBinding:
      position: 1
      prefix: -directag_complement_weight
  - id: directag_adjust_precursor
    type: ['null', string]
    doc: "DirecTag adjust precursor, 1: true, 0: false, default is '0'."
    inputBinding:
      position: 1
      prefix: -directag_adjust_precursor
  - id: directag_ms_charge_state
    type: ['null', string]
    doc: "DirecTag use charge state from M spectrum, 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -directag_ms_charge_state
  - id: annotation_level
    type: ['null', string]
    doc: "The intensity threshold to consider for annotation, e.g. using percentiles, 0.75 means that the 25% most intense peaks will be annotated, default is 0.75."
    inputBinding:
      position: 1
      prefix: -annotation_level
  - id: annotation_level_type
    type: ['null', string]
    doc: "The type of the intensity threshold. (valid values: percentile: Percentile of the intensities, snp: Signal to noise probability, default is percentile)."
    inputBinding:
      position: 1
      prefix: -annotation_level_type
  - id: annotation_mz_tolerance
    type: ['null', string]
    doc: "The m/z tolerance to annotate peaks, default is equal to the search settings MS2 tolerance."
    inputBinding:
      position: 1
      prefix: -annotation_mz_tolerance
  - id: annotation_high_resolution
    type: ['null', string]
    doc: "If true the most accurate peak will be selected within the m/z tolerance. (1: true, 0: false, default is '1')"
    inputBinding:
      position: 1
      prefix: -annotation_high_resolution
  - id: sequence_matching_type
    type: ['null', string]
    doc: "The peptide to protein sequence matching type. (0: Character Sequence, 1: Amino Acids, 2: Indistinguishable Amino Acids, default is Indistinguishable Amino Acids)"
    inputBinding:
      position: 1
      prefix: -sequence_matching_type
  - id: sequence_matching_x
    type: ['null', string]
    doc: "The maximum share of X's in a sequence, 0.25 means 25% of X's, default is 0.25."
    inputBinding:
      position: 1
      prefix: -sequence_matching_x
  - id: sequence_matching_enzymatic_tags
    type: ['null', string]
    doc: "Tags should only be mapped to enzymatic peptides. (1: true, 0: false, default is '0')"
    inputBinding:
      position: 1
      prefix: -sequence_matching_enzymatic_tags
  - id: sequence_matching_max_ptms_per_tag
    type: ['null', string]
    doc: "The maximum number of PTMs per peptide when mapping tags, default is 3."
    inputBinding:
      position: 1
      prefix: -sequence_matching_max_ptms_per_tag
  - id: sequence_matching_min_amino_acid_score
    type: ['null', string]
    doc: "The minimum amino acid score when mapping tags, default is 30."
    inputBinding:
      position: 1
      prefix: -sequence_matching_min_amino_acid_score
  - id: sequence_matching_min_tag_length
    type: ['null', string]
    doc: "The minimum tag length when mapping tags, default is 3."
    inputBinding:
      position: 1
      prefix: -sequence_matching_min_tag_length
  - id: import_peptide_length_min
    type: ['null', string]
    doc: "The minimal peptide length to consider when importing identification files, default is 8."
    inputBinding:
      position: 1
      prefix: -import_peptide_length_min
  - id: import_peptide_length_max
    type: ['null', string]
    doc: "The maximal peptide length to consider when importing identification files, default is 30."
    inputBinding:
      position: 1
      prefix: -import_peptide_length_max
  - id: import_missed_cleavages_min
    type: ['null', string]
    doc: "The minimal number if missed cleavages to consider when importing identification files, default is no filter."
    inputBinding:
      position: 1
      prefix: -import_missed_cleavages_min
  - id: import_missed_cleavages_max
    type: ['null', string]
    doc: "The maximal number if missed cleavages to consider when importing identification files, default is no filter."
    inputBinding:
      position: 1
      prefix: -import_missed_cleavages_max
  - id: import_precursor_mz
    type: ['null', string]
    doc: "The maximal precursor deviation to allow when importing identification files, the precursor tolerance by default."
    inputBinding:
      position: 1
      prefix: -import_precursor_mz
  - id: import_precursor_mz_ppm
    type: ['null', string]
    doc: "Maximal precursor ion deviation unit: ppm (1) or Da (0), default is '1'."
    inputBinding:
      position: 1
      prefix: -import_precursor_mz_ppm
  - id: exclude_unknown_ptms
    type: ['null', string]
    doc: "If true peptides presenting unrecognized PTMs will be excluded. (1: true, 0: false, default is '1')"
    inputBinding:
      position: 1
      prefix: -exclude_unknown_ptms
  - id: ptm_score
    type: ['null', string]
    doc: "The PTM probabilistic score to use for modification localization (1: PhosphoRS,2: None, default is '1')."
    inputBinding:
      position: 1
      prefix: -ptm_score
  - id: ptm_threshold
    type: ['null', string]
    doc: "The threshold to use for the modification localizatoin score. Default is 95."
    inputBinding:
      position: 1
      prefix: -ptm_threshold
  - id: score_neutral_losses
    type: ['null', string]
    doc: "Include neutral losses in spectrum annotation of the PTM score (1: true, 0: false, default is '0')."
    inputBinding:
      position: 1
      prefix: -score_neutral_losses
  - id: ptm_sequence_matching_type
    type: ['null', string]
    doc: "The modification to peptide sequence matching type. (0: Character Sequence, 1: Amino Acids, 2: Indistinguishable Amino Acids, default is Amino Acids)"
    inputBinding:
      position: 1
      prefix: -ptm_sequence_matching_type
  - id: ptm_alignment
    type: ['null', string]
    doc: "Align peptide ambiguously localized PTMs on confident sites (1: true, 0: false, default is '1')."
    inputBinding:
      position: 1
      prefix: -ptm_alignment
  - id: useGeneMapping
    type: ['null', string]
    doc: "If true gene mappings will be used and saved along with the project (UniProt databases only). (1: true, 0: false, default is '1')"
    inputBinding:
      position: 1
      prefix: -useGeneMapping
  - id: updateGeneMapping
    type: ['null', string]
    doc: "If true gene mappings will be updated automatically from Ensembl (UniProt databases only). (1: true, 0: false, default is '1')"
    inputBinding:
      position: 1
      prefix: -updateGeneMapping
  - id: simplify_groups
    type: ['null', string]
    doc: "Simplify protein groups, 1: yes, 0: no, default is 1."
    inputBinding:
      position: 1
      prefix: -simplify_groups
  - id: simplify_enzymaticity
    type: ['null', string]
    doc: "Simplify protein groups based on the peptide enzymaticity, 1: yes, 0: no, default is 1."
    inputBinding:
      position: 1
      prefix: -simplify_enzymaticity
  - id: simplify_evidence
    type: ['null', string]
    doc: "Simplify protein groups based on the Uniprot protein evidence, 1: yes, 0: no, default is 1."
    inputBinding:
      position: 1
      prefix: -simplify_evidence
  - id: simplify_confidence
    type: ['null', string]
    doc: "Simplify protein groups based on the peptide confidence, 1: yes, 0: no, default is 1."
    inputBinding:
      position: 1
      prefix: -simplify_confidence
  - id: simplify_confidence_threshold
    type: ['null', string]
    doc: "Peptide confidence threshold below which a peptide is considered absent, default is 0.05."
    inputBinding:
      position: 1
      prefix: -simplify_confidence_threshold
  - id: simplify_variant
    type: ['null', string]
    doc: "Simplify protein groups based on the variant matching, 1: yes, 0: no, default is 1."
    inputBinding:
      position: 1
      prefix: -simplify_variant
  - id: pi_modifications
    type: ['null', string]
    doc: "Account for modifications when mapping peptides to proteins, 1: yes, 0: no, default is 1."
    inputBinding:
      position: 1
      prefix: -pi_modifications
  - id: psm_fdr
    type: ['null', string]
    doc: "FDR at the PSM level in percent, default is 1."
    inputBinding:
      position: 1
      prefix: -psm_fdr
  - id: peptide_fdr
    type: ['null', string]
    doc: "FDR at the peptide level in percent, default is 1."
    inputBinding:
      position: 1
      prefix: -peptide_fdr
  - id: protein_fdr
    type: ['null', string]
    doc: "FDR at the protein level in percent, default is 1."
    inputBinding:
      position: 1
      prefix: -protein_fdr
  - id: protein_fraction_mw_confidence
    type: ['null', string]
    doc: "Minimum confidence required for a protein in the fraction MW plot (default 95%: '95.0')."
    inputBinding:
      position: 1
      prefix: -protein_fraction_mw_confidence
  - id: fasta_target_decoy
    type: ['null', string]
    doc: "FASTA file should be processed as target-decoy. 1: true, 0: false, default is '1'."
    inputBinding:
      position: 1
      prefix: -fasta_target_decoy
  - id: fasta_decoy_tag
    type: ['null', string]
    doc: "The flag for decoy proteins in the accession. Default is '-REVERSED'."
    inputBinding:
      position: 1
      prefix: -fasta_decoy_tag
  - id: fasta_decoy_type
    type: ['null', string]
    doc: "Decoy type. 0: prefix, 1: suffix, default is '1'."
    inputBinding:
      position: 1
      prefix: -fasta_decoy_type
  - id: fasta_decoy_file_tag
    type: ['null', string]
    doc: "The tag added after adding decoy sequences to a FASTA file. Default is '_concatenated_target_decoy'."
    inputBinding:
      position: 1
      prefix: -fasta_decoy_file_tag
  - id: mods
    type: ['null', string]
    doc: "Lists the available modifications."
    inputBinding:
      position: 1
      prefix: -mods
  - id: usage
    type: ['null', string]
    doc: "Lists the available options."
    inputBinding:
      position: 1
      prefix: -usage
outputs:
  - id: parameters_file
    type: File
    doc: The identification parameters file (.par)
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
stdout: searchgui_identification_parameters_cli.out
