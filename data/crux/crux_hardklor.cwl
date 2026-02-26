cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crux
  - hardklor
label: crux_hardklor
doc: "Parses high-resolution spectra from a file.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: spectra
    type: File
    doc: The name of a file from which to parse high-resolution spectra. The 
      file may be in MS1 (.ms1), binary MS1 (.bms1), compressed MS1 (.cms1), or 
      mzXML (.mzXML) format.
    inputBinding:
      position: 1
  - id: averagine_mod
    type:
      - 'null'
      - string
    doc: 'Defines alternative averagine models in the analysis that incorporate additional
      atoms and/or isotopic enrichments. Modifications are represented as text strings.
      Inclusion of additional atoms in the model is done using by entering an atomic
      formula, such as: PO2 or Cl. Inclusion of isotopic enrichment to the model is
      done by specifying the percent enrichment (as a decimal) followed by the atom
      being enriched and an index of the isotope. For example, 0.75H1 specifies 75%
      enrichment of the first heavy isotope of hydrogen. In other words, 75% deuterium
      enrichment. Two or more modifications can be combined into the same model, and
      separated by spaces: B2 0.5B1'
    default: ''
    inputBinding:
      position: 102
      prefix: --averagine-mod
  - id: boxcar_averaging
    type:
      - 'null'
      - int
    doc: Boxcar averaging is a sliding window that averages n adjacent spectra 
      prior to feature detection. Averaging generally improves the 
      signal-to-noise ratio of features in the spectra, as well as improving the
      shape of isotopic envelopes. However, averaging will also change the 
      observed peak intensities. Averaging with too wide a window will increase 
      the occurrence of overlapping features and broaden the chromatographic 
      profiles of observed features. The number specified is the total adjacent 
      scans to be combined, centered on the scan being analyzed. Therefore, an 
      odd number is recommended to center the boxcar window. For example, a 
      value of 3 would produce an average of the scan of interest, plus one scan
      on each side. A value of 0 disables boxcar averaging.
    default: 0
    inputBinding:
      position: 102
      prefix: --boxcar-averaging
  - id: boxcar_filter
    type:
      - 'null'
      - int
    doc: This parameter is only functional when boxcar-averaging is used. The 
      filter will remove any peaks not seen in n scans in the boxcar window. The
      effect is to reduce peak accumulation due to noise and reduce 
      chromatographic broadening of peaks. Caution should be used as 
      over-filtering can occur. The suggested number of scans to set for 
      filtering should be equal to or less than the boxcar-averaging window 
      size. A value of 0 disables filtering.
    default: 0
    inputBinding:
      position: 102
      prefix: --boxcar-filter
  - id: boxcar_filter_ppm
    type:
      - 'null'
      - float
    doc: This parameter is only functional when boxcar-filter is used. The value
      specifies the mass tolerance in ppm for declaring a peak the same prior to
      filtering across all scans in the boxcar window.
    default: 10.0
    inputBinding:
      position: 102
      prefix: --boxcar-filter-ppm
  - id: cdm
    type:
      - 'null'
      - string
    doc: Choose the charge state determination method.
    default: Q
    inputBinding:
      position: 102
      prefix: --cdm
  - id: centroided
    type:
      - 'null'
      - boolean
    doc: Indicates whether the data contain profile or centroided peaks.
    default: false
    inputBinding:
      position: 102
      prefix: --centroided
  - id: corr
    type:
      - 'null'
      - float
    doc: Sets the correlation threshold (cosine similarity) for accepting each 
      predicted feature.
    default: 0.85
    inputBinding:
      position: 102
      prefix: --corr
  - id: depth
    type:
      - 'null'
      - int
    doc: Sets the depth of combinatorial analysis. For a given set of peaks in a
      spectrum, search for up to this number of combined peptides that explain 
      the observed peaks. The analysis stops before depth is reached if the 
      current number of deconvolved features explains the observed peaks with a 
      correlation score above the threshold defined with the correlation 
      parameter.
    default: 3
    inputBinding:
      position: 102
      prefix: --depth
  - id: distribution_area
    type:
      - 'null'
      - boolean
    doc: When reporting each feature, report abundance as the sum of all isotope
      peaks. The value reported is the estimate of the correct peak heights 
      based on the averagine model scaled to the observed peak heights.
    default: false
    inputBinding:
      position: 102
      prefix: --distribution-area
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    default: ''
    inputBinding:
      position: 102
      prefix: --fileroot
  - id: hardklor_algorithm
    type:
      - 'null'
      - string
    doc: Determines which spectral feature detection algorithm to use. Different
      results are possible with each algorithm, and there are pros and cons to 
      each.
    default: version1
    inputBinding:
      position: 102
      prefix: --hardklor-algorithm
  - id: hardklor_data_file
    type:
      - 'null'
      - string
    doc: Specifies an ASCII text file that defines symbols for the periodic 
      table.
    default: ''
    inputBinding:
      position: 102
      prefix: --hardklor-data-file
  - id: instrument
    type:
      - 'null'
      - string
    doc: Indicates the type of instrument used to collect data. This parameter, 
      combined with the resolution parameter, define how spectra will be 
      centroided (if you provide profile spectra) and the accuracy when aligning
      observed peaks to the models.
    default: fticr
    inputBinding:
      position: 102
      prefix: --instrument
  - id: isotope_data_file
    type:
      - 'null'
      - string
    doc: Specifies an ASCII text file that can be read to override the natural 
      isotope abundances for all elements.
    default: ''
    inputBinding:
      position: 102
      prefix: --isotope-data-file
  - id: max_charge
    type:
      - 'null'
      - int
    doc: Specifies the maximum charge state to allow when finding spectral 
      features. It is best to set this value to a practical number (i.e. do not 
      set it to 20 when doing a tryptic shotgun analysis). If set higher than 
      actual charge states that are present, the algorithm will perform 
      significantly slower without any improvement in results.
    default: 5
    inputBinding:
      position: 102
      prefix: --max-charge
  - id: max_features
    type:
      - 'null'
      - int
    doc: Specifies the maximum number of models to build for a set of peaks 
      being analyzed. Regardless of the setting, the number of models will never
      exceed the number of peaks in the current set. However, as many of the low
      abundance peaks are noise or tail ends of distributions, defining models 
      for them is detrimental to the analysis.
    default: 10
    inputBinding:
      position: 102
      prefix: --max-features
  - id: min_charge
    type:
      - 'null'
      - int
    doc: Specifies the minimum charge state to allow when finding spectral 
      features. It is best to set this value to the lowest assumed charge state 
      to be present. If set higher than actual charge states that are present, 
      those features will not be identified or incorrectly assigned a different 
      charge state and mass.
    default: 1
    inputBinding:
      position: 102
      prefix: --min-charge
  - id: mz_max
    type:
      - 'null'
      - float
    doc: Constrains the search in each spectrum to signals below this value in 
      Thomsons. Setting to 0 disables this feature.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --mz-max
  - id: mz_min
    type:
      - 'null'
      - float
    doc: Constrains the search in each spectrum to signals above this value in 
      Thomsons. Setting to 0 disables this feature.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --mz-min
  - id: mz_window
    type:
      - 'null'
      - float
    doc: Only used when algorithm = version1. Defines the maximum window size in
      Thomsons to analyze when deconvolving peaks in a spectrum into features.
    default: 4.0
    inputBinding:
      position: 102
      prefix: --mz-window
  - id: mzxml_filter
    type:
      - 'null'
      - int
    doc: Filters the spectra prior to analysis for the requested MS/MS level. 
      For example, if the data contain MS and MS/MS spectra, setting 
      mzxml-filter = 1 will analyze only the MS scan events. Setting 
      mzxml-filter = 2 will analyze only the MS/MS scan events.
    default: 1
    inputBinding:
      position: 102
      prefix: --mzxml-filter
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    default: crux-output
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    default: false
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - string
    doc: A file containing parameters.
    default: ''
    inputBinding:
      position: 102
      prefix: --parameter-file
  - id: resolution
    type:
      - 'null'
      - float
    doc: Specifies the resolution of the instrument at 400 m/z for the data 
      being analyzed.
    default: 100000.0
    inputBinding:
      position: 102
      prefix: --resolution
  - id: scan_range_max
    type:
      - 'null'
      - int
    doc: Used to restrict analysis to spectra with scan numbers below this 
      parameter value. A value of 0 disables this feature.
    default: 0
    inputBinding:
      position: 102
      prefix: --scan-range-max
  - id: scan_range_min
    type:
      - 'null'
      - int
    doc: Used to restrict analysis to spectra with scan numbers above this 
      parameter value. A value of 0 disables this feature.
    default: 0
    inputBinding:
      position: 102
      prefix: --scan-range-min
  - id: sensitivity
    type:
      - 'null'
      - int
    doc: 'Set the sensitivity level. There are four levels: 0 (low), 1 (moderate),
      2 (high), and 3 (max). Increasing the sensitivity will increase computation
      time, but will also yield more isotope distributions.'
    default: 2
    inputBinding:
      position: 102
      prefix: --sensitivity
  - id: signal_to_noise
    type:
      - 'null'
      - float
    doc: Filters spectra to remove peaks below this signal-to-noise ratio prior 
      to finding features.
    default: 1.0
    inputBinding:
      position: 102
      prefix: --signal-to-noise
  - id: smooth
    type:
      - 'null'
      - int
    doc: Uses Savitzky-Golay smoothing on profile peak data prior to centroiding
      the spectra. This parameter is recommended for low resolution spectra 
      only. Smoothing data causes peak depression and broadening. Only use odd 
      numbers for the degree of smoothing (as it defines a window centered on 
      each data point). Higher values will produce smoother peaks, but with 
      greater depression and broadening. Setting this parameter to 0 disables 
      smoothing.
    default: 0
    inputBinding:
      position: 102
      prefix: --smooth
  - id: sn_window
    type:
      - 'null'
      - float
    doc: Set the signal-to-noise window length (in m/z). Because noise may be 
      non-uniform across a spectrum, this value adjusts the segment size 
      considered when calculating a signal-over-noise ratio.
    default: 250.0
    inputBinding:
      position: 102
      prefix: --sn-window
  - id: static_sn
    type:
      - 'null'
      - boolean
    doc: Applies the lowest noise threshold of any sn_window across the entire 
      mass range for a spectrum. Setting this parameter to 0 turns off this 
      feature, and different noise thresholds will be used for each local mass 
      window in a spectrum.
    default: true
    inputBinding:
      position: 102
      prefix: --static-sn
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
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_hardklor.out
