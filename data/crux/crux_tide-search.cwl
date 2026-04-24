cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux tide-search
label: crux_tide-search
doc: "Search for peptides in mass spectrometry data using the Tide algorithm.\n\n\
  Tool homepage: https://github.com/redbadger/crux"
inputs:
  - id: tide_spectra_files
    type:
      type: array
      items: File
    doc: The name of one or more files from which to parse the fragmentation 
      spectra, in any of the file formats supported by ProteoWizard. 
      Alternatively, the argument may be one or more binary spectrum files 
      produced by a previous run of crux tide-search using the store-spectra 
      parameter.
    inputBinding:
      position: 1
  - id: tide_database
    type: File
    doc: Either a FASTA file or a directory containing a database index created 
      by a previous run of crux tide-index.
    inputBinding:
      position: 2
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
  - id: isotope_error
    type:
      - 'null'
      - string
    doc: List of positive, non-zero integers.
    inputBinding:
      position: 103
      prefix: --isotope-error
  - id: mass_precision
    type:
      - 'null'
      - int
    doc: Set the precision for masses and m/z written to sqt and text files.
    inputBinding:
      position: 103
      prefix: --mass-precision
  - id: max_precursor_charge
    type:
      - 'null'
      - int
    doc: The maximum charge state of a spectra to consider in search.
    inputBinding:
      position: 103
      prefix: --max-precursor-charge
  - id: min_peaks
    type:
      - 'null'
      - int
    doc: The minimum number of peaks a spectrum must have for it to be searched.
    inputBinding:
      position: 103
      prefix: --min-peaks
  - id: mod_precision
    type:
      - 'null'
      - int
    doc: Set the precision for modifications as written to .txt files.
    inputBinding:
      position: 103
      prefix: --mod-precision
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
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 0=poll CPU to set num threads; else specify num threads directly.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: output_dir
    type:
      - 'null'
      - string
    doc: The name of the directory where output files will be created.
    inputBinding:
      position: 103
      prefix: --output-dir
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
  - id: pepxml_output
    type:
      - 'null'
      - boolean
    doc: Output a pepXML results file to the output directory.
    inputBinding:
      position: 103
      prefix: --pepxml-output
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
  - id: precision
    type:
      - 'null'
      - int
    doc: Set the precision for scores written to sqt and text files.
    inputBinding:
      position: 103
      prefix: --precision
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
  - id: print_search_progress
    type:
      - 'null'
      - int
    doc: Show search progress by printing every n spectra searched. Set to 0 to 
      show no search progress.
    inputBinding:
      position: 103
      prefix: --print-search-progress
  - id: remove_precursor_peak
    type:
      - 'null'
      - boolean
    doc: If true, all peaks around the precursor m/z will be removed, within a 
      range specified by the --remove-precursor-tolerance option.
    inputBinding:
      position: 103
      prefix: --remove-precursor-peak
  - id: remove_precursor_tolerance
    type:
      - 'null'
      - float
    doc: This parameter specifies the tolerance (in Th) around each precursor 
      m/z that is removed when the --remove-precursor-peak option is invoked.
    inputBinding:
      position: 103
      prefix: --remove-precursor-tolerance
  - id: scan_number
    type:
      - 'null'
      - string
    doc: A single scan number or a range of numbers to be searched. Range should
      be specified as 'first-last' which will include scans 'first' and 'last'.
    inputBinding:
      position: 103
      prefix: --scan-number
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
  - id: skip_preprocessing
    type:
      - 'null'
      - boolean
    doc: Skip preprocessing steps on spectra.
    inputBinding:
      position: 103
      prefix: --skip-preprocessing
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
  - id: top_match
    type:
      - 'null'
      - int
    doc: Specify the number of matches to report for each spectrum.
    inputBinding:
      position: 103
      prefix: --top-match
  - id: txt_output
    type:
      - 'null'
      - boolean
    doc: Output a tab-delimited results file to the output directory.
    inputBinding:
      position: 103
      prefix: --txt-output
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
stdout: crux_tide-search.out
