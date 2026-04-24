cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crux
  - search-for-xlinks
label: crux_search-for-xlinks
doc: "Search for cross-linked peptides in MS2 and FASTA files.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: ms2_files
    type:
      type: array
      items: File
    doc: The name of one or more files from which to parse the fragmentation 
      spectra, in any of the file formats supported by ProteoWizard.
    inputBinding:
      position: 1
  - id: protein_fasta_file
    type: File
    doc: The name of the file in FASTA format from which to retrieve proteins.
    inputBinding:
      position: 2
  - id: link_sites
    type: string
    doc: 'Specification of the the two sets of amino acids that the cross-linker can
      connect. These are specified as two comma-separated sets of amino acids, with
      the two sets separated by a colon. Cross-links involving the terminus of a protein
      can be specified by using "nterm" or "cterm". For example, "K,nterm:Q" means
      that the cross linker can attach K to Q or the protein N-terminus to Q. Note
      that the vast majority of cross-linkers will operate on the following reactive
      groups: amine (K,nterm), carboxyl (D,E,cterm), sulfhydrl (C), acyl (Q) or amine+
      (K,S,T,Y,nterm).'
    inputBinding:
      position: 3
  - id: link_mass
    type: string
    doc: The mass modification of the linker when attached to a peptide.
    inputBinding:
      position: 4
  - id: cmod
    type:
      - 'null'
      - string
    doc: Specify a variable modification to apply to C-terminus of peptides. . 
      Note that this parameter only takes effect when specified in the parameter
      file.
    inputBinding:
      position: 105
      prefix: --cmod
  - id: compute_p_values
    type:
      - 'null'
      - boolean
    doc: Estimate the parameters of the score distribution for each spectrum by 
      fitting to a Weibull distribution, and compute a p-value for each xlink 
      product. This option is only available when use-old-xlink=F.
    inputBinding:
      position: 105
      prefix: --compute-p-values
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
      position: 105
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
      position: 105
      prefix: --concat
  - id: custom_enzyme
    type:
      - 'null'
      - string
    doc: Specify rules for in silico digestion of protein sequences. Overrides 
      the enzyme option. Two lists of residues are given enclosed in square 
      brackets or curly braces and separated by a |. The first list contains 
      residues required/prohibited before the cleavage site and the second list 
      is residues after the cleavage site. If the residues are required for 
      digestion, they are in square brackets, '[' and ']'. If the residues 
      prevent digestion, then they are enclosed in curly braces, '{' and '}'. 
      Use X to indicate all residues. For example, trypsin cuts after R or K but
      not before P which is represented as [RK]|{P}. AspN cuts after any residue
      but only before D which is represented as [X]|[D]. To prevent the 
      sequences from being digested at all, use [Z]|[Z].
    inputBinding:
      position: 105
      prefix: --custom-enzyme
  - id: digestion
    type:
      - 'null'
      - string
    doc: Specify whether every peptide in the database must have two enzymatic 
      termini (full-digest) or if peptides with only one enzymatic terminus are 
      also included (partial-digest).
    inputBinding:
      position: 105
      prefix: --digestion
  - id: enzyme
    type:
      - 'null'
      - string
    doc: 'Specify the enzyme used to digest the proteins in silico. Available enzymes
      (with the corresponding digestion rules indicated in parentheses) include no-enzyme
      ([X]|[X]), trypsin ([RK]|{P}), trypsin/p ([RK]|[]), chymotrypsin ([FWYL]|{P}),
      elastase ([ALIV]|{P}), clostripain ([R]|[]), cyanogen-bromide ([M]|[]), iodosobenzoate
      ([W]|[]), proline-endopeptidase ([P]|[]), staph-protease ([E]|[]), asp-n ([]|[D]),
      lys-c ([K]|{P}), lys-n ([]|[K]), arg-c ([R]|{P}), glu-c ([DE]|{P}), pepsin-a
      ([FL]|{P}), elastase-trypsin-chymotrypsin ([ALIVKRWFY]|{P}). Specifying --enzyme
      no-enzyme yields a non-enzymatic digest. Warning: the resulting index may be
      quite large.'
    inputBinding:
      position: 105
      prefix: --enzyme
  - id: file_column
    type:
      - 'null'
      - boolean
    doc: Include the file column in tab-delimited output.
    inputBinding:
      position: 105
      prefix: --file-column
  - id: fragment_mass
    type:
      - 'null'
      - string
    doc: Specify which isotopes to use in calculating fragment ion mass.
    inputBinding:
      position: 105
      prefix: --fragment-mass
  - id: isotope_windows
    type:
      - 'null'
      - string
    doc: 'Provides a list of isotopic windows to search. For example, -1,0,1 will
      search in three disjoint windows: (1) precursor_mass - neutron_mass +/- window,
      (2) precursor_mass +/- window, and (3) precursor_mass + neutron_mass +/- window.
      The window size is defined from the precursor-window and precursor-window-type
      parameters. This option is only available when use-old-xlink=F.'
    inputBinding:
      position: 105
      prefix: --isotope-windows
  - id: isotopic_mass
    type:
      - 'null'
      - string
    doc: Specify the type of isotopic masses to use when calculating the peptide
      mass.
    inputBinding:
      position: 105
      prefix: --isotopic-mass
  - id: max_ion_charge
    type:
      - 'null'
      - string
    doc: Predict theoretical ions up to max charge state (1, 2, ... ,6) or up to
      the charge state of the peptide ("peptide"). If the max-ion-charge is 
      greater than the charge state of the peptide, then the maximum is the 
      peptide charge.
    inputBinding:
      position: 105
      prefix: --max-ion-charge
  - id: max_length
    type:
      - 'null'
      - int
    doc: The maximum length of peptides to consider.
    inputBinding:
      position: 105
      prefix: --max-length
  - id: max_mass
    type:
      - 'null'
      - float
    doc: The maximum mass (in Da) of peptides to consider.
    inputBinding:
      position: 105
      prefix: --max-mass
  - id: max_mods
    type:
      - 'null'
      - int
    doc: The maximum number of modifications that can be applied to a single 
      peptide.
    inputBinding:
      position: 105
      prefix: --max-mods
  - id: max_xlink_mods
    type:
      - 'null'
      - int
    doc: Specify the maximum number of modifications allowed on a crosslinked 
      peptide. This option is only available when use-old-xlink=F.
    inputBinding:
      position: 105
      prefix: --max-xlink-mods
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of peptides to consider.
    inputBinding:
      position: 105
      prefix: --min-length
  - id: min_mass
    type:
      - 'null'
      - float
    doc: The minimum mass (in Da) of peptides to consider.
    inputBinding:
      position: 105
      prefix: --min-mass
  - id: min_weibull_points
    type:
      - 'null'
      - int
    doc: Keep shuffling and collecting XCorr scores until the minimum number of 
      points for weibull fitting (using targets and decoys) is achieved.
    inputBinding:
      position: 105
      prefix: --min-weibull-points
  - id: missed_cleavages
    type:
      - 'null'
      - int
    doc: Maximum number of missed cleavages per peptide to allow in enzymatic 
      digestion.
    inputBinding:
      position: 105
      prefix: --missed-cleavages
  - id: mod_mass_format
    type:
      - 'null'
      - string
    doc: "Specify how sequence modifications are reported in various output files.
      Each modification is reported as a number enclosed in square braces following
      the modified residue; however, the number may correspond to one of three different
      masses: (1) 'mod-only' reports the value of the mass shift induced by the modification;
      (2) 'total' reports the mass of the residue with the modification (residue mass
      plus modification mass); (3) 'separate' is the same as 'mod-only', but multiple
      modifications to a single amino acid are reported as a comma-separated list
      of values. For example, suppose amino acid D has an unmodified mass of 115 as
      well as two moifications of masses +14 and +2. In this case, the amino acid
      would be reported as D[16] with 'mod-only', D[131] with 'total', and D[14,2]
      with 'separate'."
    inputBinding:
      position: 105
      prefix: --mod-mass-format
  - id: mod_precision
    type:
      - 'null'
      - int
    doc: Set the precision for modifications as written to .txt files.
    inputBinding:
      position: 105
      prefix: --mod-precision
  - id: mods_spec
    type:
      - 'null'
      - string
    doc: 'Expression for static and variable mass modifications to include. Specify
      a comma-separated list of modification sequences of the form: C+57.02146,2M+15.9949,1STY+79.966331,...'
    inputBinding:
      position: 105
      prefix: --mods-spec
  - id: mono_link
    type:
      - 'null'
      - string
    doc: Provides a list of amino acids and their mass modifications to consider
      as candidate for mono-/dead- links. Format is the same as mods-spec.
    inputBinding:
      position: 105
      prefix: --mono-link
  - id: mz_bin_offset
    type:
      - 'null'
      - float
    doc: In the discretization of the m/z axes of the observed and theoretical 
      spectra, this parameter specifies the location of the left edge of the 
      first bin, relative to mass = 0 (i.e., mz-bin-offset = 0.xx means the left
      edge of the first bin will be located at +0.xx Da).
    inputBinding:
      position: 105
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
      position: 105
      prefix: --mz-bin-width
  - id: nmod
    type:
      - 'null'
      - string
    doc: Specify a variable modification to apply to N-terminus of peptides. . 
      Note that this parameter only takes effect when specified in the parameter
      file.
    inputBinding:
      position: 105
      prefix: --nmod
  - id: output_dir
    type:
      - 'null'
      - string
    doc: The name of the directory where output files will be created.
    inputBinding:
      position: 105
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    inputBinding:
      position: 105
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - string
    doc: A file containing parameters.
    inputBinding:
      position: 105
      prefix: --parameter-file
  - id: precursor_window
    type:
      - 'null'
      - float
    doc: Tolerance used for matching peptides to spectra. Peptides must be 
      within +/- 'precursor-window' of the spectrum value. The precursor window 
      units depend upon precursor-window-type.
    inputBinding:
      position: 105
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
      position: 105
      prefix: --precursor-window-type
  - id: precursor_window_type_weibull
    type:
      - 'null'
      - string
    doc: Window type to use in conjunction with the precursor-window-weibull 
      parameter.
    inputBinding:
      position: 105
      prefix: --precursor-window-type-weibull
  - id: precursor_window_weibull
    type:
      - 'null'
      - float
    doc: Search decoy peptides within +/- precursor-window-weibull of the 
      precursor mass. The resulting scores are used only for fitting the Weibull
      distribution
    inputBinding:
      position: 105
      prefix: --precursor-window-weibull
  - id: print_search_progress
    type:
      - 'null'
      - int
    doc: Show search progress by printing every n spectra searched. Set to 0 to 
      show no search progress.
    inputBinding:
      position: 105
      prefix: --print-search-progress
  - id: require_xlink_candidate
    type:
      - 'null'
      - boolean
    doc: If there is no cross-link candidate found, then don't bother looking 
      for linear, self-loop, and dead-link candidates.
    inputBinding:
      position: 105
      prefix: --require-xlink-candidate
  - id: scan_number
    type:
      - 'null'
      - string
    doc: A single scan number or a range of numbers to be searched. Range should
      be specified as 'first-last' which will include scans 'first' and 'last'.
    inputBinding:
      position: 105
      prefix: --scan-number
  - id: seed
    type:
      - 'null'
      - string
    doc: When given a unsigned integer value seeds the random number generator 
      with that value. When given the string "time" seeds the random number 
      generator with the system time.
    inputBinding:
      position: 105
      prefix: --seed
  - id: spectrum_charge
    type:
      - 'null'
      - string
    doc: The spectrum charges to search. With 'all' every spectrum will be 
      searched and spectra with multiple charge states will be searched once at 
      each charge state. With 1, 2, or 3 only spectra with that charge state 
      will be searched.
    inputBinding:
      position: 105
      prefix: --spectrum-charge
  - id: spectrum_max_mz
    type:
      - 'null'
      - float
    doc: The highest spectrum m/z to search in the ms2 file.
    inputBinding:
      position: 105
      prefix: --spectrum-max-mz
  - id: spectrum_min_mz
    type:
      - 'null'
      - float
    doc: The lowest spectrum m/z to search in the ms2 file.
    inputBinding:
      position: 105
      prefix: --spectrum-min-mz
  - id: spectrum_parser
    type:
      - 'null'
      - string
    doc: Specify the parser to use for reading in MS/MS spectra.
    inputBinding:
      position: 105
      prefix: --spectrum-parser
  - id: top_match
    type:
      - 'null'
      - int
    doc: Specify the number of matches to report for each spectrum.
    inputBinding:
      position: 105
      prefix: --top-match
  - id: use_a_ions
    type:
      - 'null'
      - boolean
    doc: Consider a-ions in the search? Note that an a-ion is equivalent to a 
      neutral loss of CO from the b-ion. Peak height is 10 (in arbitrary units).
    inputBinding:
      position: 105
      prefix: --use-a-ions
  - id: use_b_ions
    type:
      - 'null'
      - boolean
    doc: Consider b-ions in the search? Peak height is 50 (in arbitrary units).
    inputBinding:
      position: 105
      prefix: --use-b-ions
  - id: use_c_ions
    type:
      - 'null'
      - boolean
    doc: Consider c-ions in the search? Peak height is 50 (in arbitrary units).
    inputBinding:
      position: 105
      prefix: --use-c-ions
  - id: use_flanking_peaks
    type:
      - 'null'
      - boolean
    doc: Include flanking peaks around singly charged b and y theoretical ions. 
      Each flanking peak occurs in the adjacent m/z bin and has half the 
      intensity of the primary peak.
    inputBinding:
      position: 105
      prefix: --use-flanking-peaks
  - id: use_old_xlink
    type:
      - 'null'
      - boolean
    doc: Use the old version of xlink-searching algorithm. When false, a new 
      version of the code is run. The new version supports variable 
      modifications and can handle more complex databases. This new code is 
      still in development and should be considered a beta release.
    inputBinding:
      position: 105
      prefix: --use-old-xlink
  - id: use_x_ions
    type:
      - 'null'
      - boolean
    doc: Consider x-ions in the search? Peak height is 10 (in arbitrary units).
    inputBinding:
      position: 105
      prefix: --use-x-ions
  - id: use_y_ions
    type:
      - 'null'
      - boolean
    doc: Consider y-ions in the search? Peak height is 50 (in arbitrary units).
    inputBinding:
      position: 105
      prefix: --use-y-ions
  - id: use_z_ions
    type:
      - 'null'
      - boolean
    doc: Consider z-ions in the search? Peak height is 50 (in arbitrary units).
    inputBinding:
      position: 105
      prefix: --use-z-ions
  - id: use_z_line
    type:
      - 'null'
      - boolean
    doc: Specify whether, when parsing an MS2 spectrum file, Crux obtains the 
      precursor mass information from the "S" line or the "Z" line.
    inputBinding:
      position: 105
      prefix: --use-z-line
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    inputBinding:
      position: 105
      prefix: --verbosity
  - id: xlink_include_deadends
    type:
      - 'null'
      - boolean
    doc: Include dead-end peptides in the search.
    inputBinding:
      position: 105
      prefix: --xlink-include-deadends
  - id: xlink_include_inter
    type:
      - 'null'
      - boolean
    doc: Include inter-protein cross-link candidates within the search.
    inputBinding:
      position: 105
      prefix: --xlink-include-inter
  - id: xlink_include_inter_intra
    type:
      - 'null'
      - boolean
    doc: Include crosslink candidates that are both inter and intra.
    inputBinding:
      position: 105
      prefix: --xlink-include-inter-intra
  - id: xlink_include_intra
    type:
      - 'null'
      - boolean
    doc: Include intra-protein cross-link candiates within the search.
    inputBinding:
      position: 105
      prefix: --xlink-include-intra
  - id: xlink_include_linears
    type:
      - 'null'
      - boolean
    doc: Include linear peptides in the search.
    inputBinding:
      position: 105
      prefix: --xlink-include-linears
  - id: xlink_include_selfloops
    type:
      - 'null'
      - boolean
    doc: Include self-loop peptides in the search.
    inputBinding:
      position: 105
      prefix: --xlink-include-selfloops
  - id: xlink_prevents_cleavage
    type:
      - 'null'
      - string
    doc: List of amino acids for which the cross-linker can prevent cleavage. 
      This option is only available when use-old-xlink=F.
    inputBinding:
      position: 105
      prefix: --xlink-prevents-cleavage
  - id: xlink_top_n
    type:
      - 'null'
      - int
    doc: Specify the number of open-mod peptides to consider in the second pass.
      A value of 0 will search all candiates.
    inputBinding:
      position: 105
      prefix: --xlink-top-n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_search-for-xlinks.out
