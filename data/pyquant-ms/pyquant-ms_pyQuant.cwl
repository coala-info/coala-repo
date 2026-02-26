cwlVersion: v1.2
class: CommandLineTool
baseCommand: PyQuant
label: pyquant-ms_pyQuant
doc: "This will quantify labeled peaks (such as SILAC) in ms1 spectra. It relies solely
  on the distance between peaks, which can correct for errors due to amino acid conversions.\n\
  \nTool homepage: https://chris7.github.io/pyquant/"
inputs:
  - id: charge
    type:
      - 'null'
      - string
    doc: The column indicating the charge state of the ion.
    default: Charge
    inputBinding:
      position: 101
      prefix: --charge
  - id: debug
    type:
      - 'null'
      - boolean
    doc: This will output debug information.
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_peak_filtering
    type:
      - 'null'
      - boolean
    doc: This will disable smoothing of data prior to peak finding. If you have 
      very good LC, this may be used to identify small peaks.
    default: false
    inputBinding:
      position: 101
      prefix: --disable-peak-filtering
  - id: disable_stats
    type:
      - 'null'
      - boolean
    doc: Disable confidence statistics on data.
    default: false
    inputBinding:
      position: 101
      prefix: --disable-stats
  - id: export_mode
    type:
      - 'null'
      - string
    doc: 'How to export the scans. per-peak: A mzML per peak identified. per-id: A
      mzML per ion identified (each row of the output gets an mzML). per-file: All
      scans matched per raw file.'
    default: per-peak
    inputBinding:
      position: 101
      prefix: --export-mode
  - id: export_msn
    type:
      - 'null'
      - boolean
    doc: This will export spectra of a given MSN that were used to provide the 
      quantification.
    default: true
    inputBinding:
      position: 101
      prefix: --export-msn
  - id: export_mzml
    type:
      - 'null'
      - boolean
    doc: Create an mzml file of spectra contained within each peak.
    default: false
    inputBinding:
      position: 101
      prefix: --export-mzml
  - id: filter_width
    type:
      - 'null'
      - int
    doc: 'The window size for snr/zscore filtering. Default: entire scan'
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-width
  - id: fit_baseline
    type:
      - 'null'
      - boolean
    doc: Fit a separate line for the baseline of each peak.
    default: false
    inputBinding:
      position: 101
      prefix: --fit-baseline
  - id: gap_interpolation
    type:
      - 'null'
      - int
    doc: This interpolates missing data in scans. The parameter should be a 
      number that is the maximal gap size to fill (ie 2 means a gap of 2 scans).
      Can be useful for low intensity LC-MS data.
    default: 0
    inputBinding:
      position: 101
      prefix: --gap-interpolation
  - id: gcms
    type:
      - 'null'
      - boolean
    doc: This will select parameters specific for ion identification and 
      quantification in GCMS experiments.
    default: false
    inputBinding:
      position: 101
      prefix: --gcms
  - id: html
    type:
      - 'null'
      - boolean
    doc: Output a HTML table summary.
    default: false
    inputBinding:
      position: 101
      prefix: --html
  - id: intensity_filter
    type:
      - 'null'
      - float
    doc: Filter peaks whose peak are below a given intensity.
    default: 0
    inputBinding:
      position: 101
      prefix: --intensity-filter
  - id: isobaric_tags
    type:
      - 'null'
      - boolean
    doc: This will select parameters specific for isobaric tag based labeling 
      (TMT/iTRAQ).
    default: false
    inputBinding:
      position: 101
      prefix: --isobaric-tags
  - id: isotope_ppm
    type:
      - 'null'
      - float
    doc: The mass accuracy for the isotopic cluster.
    default: 2.5
    inputBinding:
      position: 101
      prefix: --isotope-ppm
  - id: isotopologue_limit
    type:
      - 'null'
      - int
    doc: How many isotopologues to quantify
    default: -1
    inputBinding:
      position: 101
      prefix: --isotopologue-limit
  - id: label
    type:
      - 'null'
      - string
    doc: The column indicating the label state of the peptide. If not found, 
      entry assumed to be light variant.
    default: Labeling State
    inputBinding:
      position: 101
      prefix: --label
  - id: label_method
    type:
      - 'null'
      - string
    doc: Predefined labeling schemes to use.
    default: None
    inputBinding:
      position: 101
      prefix: --label-method
  - id: label_scheme
    type:
      - 'null'
      - File
    doc: The file corresponding to the labeling scheme utilized.
    default: None
    inputBinding:
      position: 101
      prefix: --label-scheme
  - id: labels_needed
    type:
      - 'null'
      - int
    doc: How many labels need to be detected to quantify a scan (ie if you have 
      a 2 state experiment and set this to 2, it will only quantify scans where 
      both occur.
    default: 1
    inputBinding:
      position: 101
      prefix: --labels-needed
  - id: max_peaks
    type:
      - 'null'
      - int
    doc: The maximal number of peaks to detect per scan. A lower value can help 
      with very noisy data.
    default: -1
    inputBinding:
      position: 101
      prefix: --max-peaks
  - id: maxquant
    type:
      - 'null'
      - boolean
    doc: This will select parameters specific for a MaxQuant evidence file.
    default: false
    inputBinding:
      position: 101
      prefix: --maxquant
  - id: merge_isotopes
    type:
      - 'null'
      - boolean
    doc: Merge Isotopologues together prior to fitting.
    default: false
    inputBinding:
      position: 101
      prefix: --merge-isotopes
  - id: merge_labels
    type:
      - 'null'
      - boolean
    doc: Merge labels together to a single XIC.
    default: false
    inputBinding:
      position: 101
      prefix: --merge-labels
  - id: min_peak_separation
    type:
      - 'null'
      - int
    doc: Peaks separated by less than this distance will be combined. For very 
      crisp data, set this to a lower number. (minimal value is 1)
    default: 5
    inputBinding:
      position: 101
      prefix: --min-peak-separation
  - id: min_resolution
    type:
      - 'null'
      - int
    doc: The minimal resolving power of a scan to consider for quantification. 
      Useful for skipping low-res scans
    default: 0
    inputBinding:
      position: 101
      prefix: --min-resolution
  - id: min_scans
    type:
      - 'null'
      - int
    doc: How many quantification scans are needed to quantify a scan.
    default: 1
    inputBinding:
      position: 101
      prefix: --min-scans
  - id: ms3
    type:
      - 'null'
      - boolean
    doc: This will select parameters specific for ms3 based quantification.
    default: false
    inputBinding:
      position: 101
      prefix: --ms3
  - id: msn_all_scans
    type:
      - 'null'
      - boolean
    doc: Search for the ion across all scans (ie if you have 3 ions, you will 
      have 3 results with one long XIC)
    default: false
    inputBinding:
      position: 101
      prefix: --msn-all-scans
  - id: msn_id
    type:
      - 'null'
      - int
    doc: 'The ms level to search for the ion in. Default: 2 (ms2)'
    default: 2
    inputBinding:
      position: 101
      prefix: --msn-id
  - id: msn_ion
    type:
      - 'null'
      - type: array
        items: string
    doc: M/Z values to search for in the scans. To search for multiple m/z 
      values for a given ion, separate m/z values with a comma.
    default: None
    inputBinding:
      position: 101
      prefix: --msn-ion
  - id: msn_ion_rt
    type:
      - 'null'
      - type: array
        items: string
    doc: RT values each ion is expected at.
    default: None
    inputBinding:
      position: 101
      prefix: --msn-ion-rt
  - id: msn_peaklist
    type:
      - 'null'
      - File
    doc: A file containing peaks to search for in the scans.
    default: None
    inputBinding:
      position: 101
      prefix: --msn-peaklist
  - id: msn_ppm
    type:
      - 'null'
      - int
    doc: The error tolerance for identifying the ion(s).
    default: 200
    inputBinding:
      position: 101
      prefix: --msn-ppm
  - id: msn_quant_from
    type:
      - 'null'
      - string
    doc: 'The ms level to quantify values from. i.e. if we are identifying an ion
      in ms2, we can quantify it in ms1 (or ms2). Default: msn value-1'
    default: None
    inputBinding:
      position: 101
      prefix: --msn-quant-from
  - id: msn_rt_window
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The range of retention times for identifying the ion(s). (ex: 7.54-9.43)'
    default: None
    inputBinding:
      position: 101
      prefix: --msn-rt-window
  - id: mva
    type:
      - 'null'
      - boolean
    doc: Analyze files in 'missing value' mode.
    default: false
    inputBinding:
      position: 101
      prefix: --mva
  - id: mz
    type:
      - 'null'
      - string
    doc: The column indicating the MZ value of the precursor ion. This is not 
      the MH+.
    default: Light Precursor
    inputBinding:
      position: 101
      prefix: --mz
  - id: neucode
    type:
      - 'null'
      - boolean
    doc: 'This will select parameters specific for neucode. Note: You still must define
      a labeling scheme.'
    default: false
    inputBinding:
      position: 101
      prefix: --neucode
  - id: no_contaminant_detection
    type:
      - 'null'
      - boolean
    doc: Disables routine to check if an ion is a contaminant of a nearby 
      peptide (checks if its a likely isotopologue).
    default: false
    inputBinding:
      position: 101
      prefix: --no-contaminant-detection
  - id: no_mass_accuracy_correction
    type:
      - 'null'
      - boolean
    doc: Disables the mass accuracy correction.
    default: false
    inputBinding:
      position: 101
      prefix: --no-mass-accuracy-correction
  - id: no_ratios
    type:
      - 'null'
      - boolean
    doc: Disable reporting of ratios in output.
    default: false
    inputBinding:
      position: 101
      prefix: --no-ratios
  - id: no_rt_guide
    type:
      - 'null'
      - boolean
    doc: Do not use the retention time to bias for peaks containing the MS 
      trigger time.
    default: false
    inputBinding:
      position: 101
      prefix: --no-rt-guide
  - id: out
    type:
      - 'null'
      - string
    doc: The prefix for the file output
    default: None
    inputBinding:
      position: 101
      prefix: --out
  - id: overlapping_labels
    type:
      - 'null'
      - boolean
    doc: This declares the mz values of labels will overlap. It is useful for 
      data such as neucode, but not needed for only SILAC labeling.
    default: false
    inputBinding:
      position: 101
      prefix: --overlapping-labels
  - id: peak_cutoff
    type:
      - 'null'
      - float
    doc: The threshold from the initial retention time a peak can fall by before
      being discarded
    default: 0.05
    inputBinding:
      position: 101
      prefix: --peak-cutoff
  - id: peak_find_method
    type:
      - 'null'
      - string
    doc: The method to use to identify peaks within data. For LC-MS, 
      relative-max is usually best. For smooth data, derivative is better.
    default: relative-max
    inputBinding:
      position: 101
      prefix: --peak-find-method
  - id: peak_find_mode
    type:
      - 'null'
      - string
    doc: This picks some predefined parameters for various use cases. Fast is 
      good for robust data with few peaks, slow is good for complex data with 
      overlapping peaks of very different size.
    default: average
    inputBinding:
      position: 101
      prefix: --peak-find-mode
  - id: peak_resolution_mode
    type:
      - 'null'
      - string
    doc: The method to use to resolve peaks across multiple XICs
    default: common-peak
    inputBinding:
      position: 101
      prefix: --peak-resolution-mode
  - id: peaks_n
    type:
      - 'null'
      - int
    doc: The number of peaks to report per scan. Useful for ions with multiple 
      elution times.
    default: 1
    inputBinding:
      position: 101
      prefix: --peaks-n
  - id: peptide
    type:
      - 'null'
      - type: array
        items: string
    doc: The peptide(s) to limit quantification to.
    default: None
    inputBinding:
      position: 101
      prefix: --peptide
  - id: peptide_col
    type:
      - 'null'
      - string
    doc: The column indicating the peptide.
    default: Peptide
    inputBinding:
      position: 101
      prefix: --peptide-col
  - id: peptide_file
    type:
      - 'null'
      - File
    doc: A file of peptide(s) to limit quantification to.
    default: None
    inputBinding:
      position: 101
      prefix: --peptide-file
  - id: percentile_filter
    type:
      - 'null'
      - float
    doc: Filter peaks whose peak are below a given percentile of the data.
    default: 0
    inputBinding:
      position: 101
      prefix: --percentile-filter
  - id: precision
    type:
      - 'null'
      - int
    doc: The precision for storing m/z values. Defaults to 6 decimal places.
    default: 6
    inputBinding:
      position: 101
      prefix: --precision
  - id: precursor_ppm
    type:
      - 'null'
      - float
    doc: The mass accuracy for the first monoisotopic peak in ppm.
    default: 5
    inputBinding:
      position: 101
      prefix: --precursor-ppm
  - id: quant_method
    type:
      - 'null'
      - string
    doc: 'The process to use for quantification. Default: Integrate for ms1, sum for
      ms2+.'
    default: None
    inputBinding:
      position: 101
      prefix: --quant-method
  - id: r2_cutoff
    type:
      - 'null'
      - float
    doc: The minimal R^2 for a peak to be kept. Should be a value between 0 and 
      1
    default: None
    inputBinding:
      position: 101
      prefix: --r2-cutoff
  - id: reference_label
    type:
      - 'null'
      - string
    doc: The label to use as a reference (by default all comparisons are taken).
    default: None
    inputBinding:
      position: 101
      prefix: --reference-label
  - id: reporter_ion
    type:
      - 'null'
      - boolean
    doc: Indicates that reporter ions are being used. As such, we only analyze a
      single scan.
    default: false
    inputBinding:
      position: 101
      prefix: --reporter-ion
  - id: require_all_ions
    type:
      - 'null'
      - boolean
    doc: If multiple ions are set (in the style of 93.15,105.15), all ions must 
      be found in a scan.
    default: false
    inputBinding:
      position: 101
      prefix: --require-all-ions
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Will resume from the last run. Only works if not directing output to 
      stdout.
    default: false
    inputBinding:
      position: 101
      prefix: --resume
  - id: rt
    type:
      - 'null'
      - string
    doc: The column indicating the retention time.
    default: Retention time
    inputBinding:
      position: 101
      prefix: --rt
  - id: rt_window
    type:
      - 'null'
      - float
    doc: The maximal deviation of a scan's retention time to be considered for 
      analysis.
    default: 0.25
    inputBinding:
      position: 101
      prefix: --rt-window
  - id: sample
    type:
      - 'null'
      - float
    doc: How much of the data to sample. Enter as a decimal (ie 1.0 for 
      everything, 0.1 for 10%)
    default: 1.0
    inputBinding:
      position: 101
      prefix: --sample
  - id: scan
    type:
      - 'null'
      - type: array
        items: string
    doc: The scan(s) to limit quantification to.
    default: None
    inputBinding:
      position: 101
      prefix: --scan
  - id: scan_col
    type:
      - 'null'
      - string
    doc: The column indicating the scan corresponding to the ion.
    default: MS2 Spectrum ID
    inputBinding:
      position: 101
      prefix: --scan-col
  - id: scan_file
    type:
      - 'null'
      - type: array
        items: File
    doc: The scan file(s) for the raw data. If not provided, assumed to be in 
      the directory of the processed/tabbed/peaklist file.
    default: None
    inputBinding:
      position: 101
      prefix: --scan-file
  - id: scan_file_dir
    type:
      - 'null'
      - Directory
    doc: The directory containing raw data.
    default: None
    inputBinding:
      position: 101
      prefix: --scan-file-dir
  - id: search_file
    type:
      - 'null'
      - File
    doc: A search output or Proteome Discoverer msf file
    default: None
    inputBinding:
      position: 101
      prefix: --search-file
  - id: skip
    type:
      - 'null'
      - boolean
    doc: If true, skip scans with missing files in the mapping.
    default: false
    inputBinding:
      position: 101
      prefix: --skip
  - id: snr_filter
    type:
      - 'null'
      - float
    doc: Filter peaks below a given SNR.
    default: 0
    inputBinding:
      position: 101
      prefix: --snr-filter
  - id: source
    type:
      - 'null'
      - string
    doc: The column indicating the raw file the scan is contained in.
    default: Raw file
    inputBinding:
      position: 101
      prefix: --source
  - id: spread
    type:
      - 'null'
      - boolean
    doc: Assume there is spread of the isotopic label.
    default: false
    inputBinding:
      position: 101
      prefix: --spread
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to run
    default: 1
    inputBinding:
      position: 101
      prefix: -p
  - id: tsv
    type:
      - 'null'
      - File
    doc: A delimited file containing scan information.
    default: None
    inputBinding:
      position: 101
      prefix: --tsv
  - id: xic_missing_ion_count
    type:
      - 'null'
      - int
    doc: This specifies how many consequtive scans an ion can be missing for 
      until it is no longer considered.
    default: 1
    inputBinding:
      position: 101
      prefix: --xic-missing-ion-count
  - id: xic_smooth
    type:
      - 'null'
      - boolean
    doc: Prior to fitting, smooth data with a Gaussian filter.
    default: false
    inputBinding:
      position: 101
      prefix: --xic-smooth
  - id: xic_snr
    type:
      - 'null'
      - float
    doc: When the SNR of the XIC falls below this, stop searching for more data.
      Useful for escaping from noisy shoulders and contaminants.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --xic-snr
  - id: xic_window_size
    type:
      - 'null'
      - int
    doc: When the number of scans in a given direction from the initial 
      datapoint of an XIC passes this, stop. Default is -1 (disabled). Useful 
      for removing contaminants
    default: -1
    inputBinding:
      position: 101
      prefix: --xic-window-size
  - id: zscore_filter
    type:
      - 'null'
      - float
    doc: Peaks below a given z-score are excluded.
    default: 0
    inputBinding:
      position: 101
      prefix: --zscore-filter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyquant-ms:0.2.4--py27hc1659b7_0
stdout: pyquant-ms_pyQuant.out
