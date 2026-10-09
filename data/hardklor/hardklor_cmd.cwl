cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hardklor
  - -cmd
label: hardklor_cmd
doc: "Hardklor in command-line mode: detects isotope-distribution features (peptide
  and small-molecule features) in high-resolution mass spectra, with all settings
  given as options instead of a configuration file.\n\nTool homepage: https://github.com/mhoopmann/hardklor"
inputs:
  - id: input_file
    type: File
    doc: Input spectra file (mzML, mzXML, ms1, ms2, mgf, ...); the extension sets the format
    inputBinding:
      position: 200
  - id: output_file_name
    type: string
    doc: Name of the output file (by convention .hk)
    inputBinding:
      position: 201
  - id: algorithm
    type:
      - 'null'
      - string
    doc: "Algorithm: Basic, Version1 or Version2"
    inputBinding:
      position: 1
      prefix: -algorithm
  - id: averagine_mod
    type:
      - 'null'
      - string
    doc: Formula containing modifications to the averagine model; 0 clears all modifications
    inputBinding:
      position: 1
      prefix: -averagine_mod
  - id: boxcar_averaging
    type:
      - 'null'
      - int
    doc: Number of scans to average together (odd numbers only), 0 = off
    inputBinding:
      position: 1
      prefix: -boxcar_averaging
  - id: boxcar_filter
    type:
      - 'null'
      - int
    doc: When boxcar averaging, only keep peaks seen in this number of scans, 0 = off
    inputBinding:
      position: 1
      prefix: -boxcar_filter
  - id: boxcar_filter_ppm
    type:
      - 'null'
      - float
    doc: Tolerance in ppm for matching peaks across spectra in the boxcar filter
    inputBinding:
      position: 1
      prefix: -boxcar_filter_ppm
  - id: centroided
    type:
      - 'null'
      - int
    doc: "Input data are centroided: 0 = no, 1 = yes"
    inputBinding:
      position: 1
      prefix: -centroided
  - id: charge_algorithm
    type:
      - 'null'
      - string
    doc: "Charge identification method: Quick, FFT, Patterson, Senko or None"
    inputBinding:
      position: 1
      prefix: -charge_algorithm
  - id: charge_max
    type:
      - 'null'
      - int
    doc: Highest charge state allowed in the analysis
    inputBinding:
      position: 1
      prefix: -charge_max
  - id: charge_min
    type:
      - 'null'
      - int
    doc: Lowest charge state allowed in the analysis
    inputBinding:
      position: 1
      prefix: -charge_min
  - id: correlation
    type:
      - 'null'
      - float
    doc: Correlation threshold to accept a peptide feature
    inputBinding:
      position: 1
      prefix: -correlation
  - id: depth
    type:
      - 'null'
      - int
    doc: Depth of combinatorial analysis (maximum number of overlapping features in an mz_window)
    inputBinding:
      position: 1
      prefix: -depth
  - id: distribution_area
    type:
      - 'null'
      - int
    doc: "Report the sum of distribution peaks instead of the highest peak: 0 = off, 1 = on"
    inputBinding:
      position: 1
      prefix: -distribution_area
  - id: hardklor_data
    type:
      - 'null'
      - File
    doc: Hardklor.dat data file (isotope model data)
    inputBinding:
      position: 1
      prefix: -hardklor_data
  - id: instrument
    type:
      - 'null'
      - string
    doc: "Instrument type: FTICR, Orbitrap, TOF or QIT"
    inputBinding:
      position: 1
      prefix: -instrument
  - id: isotope_data
    type:
      - 'null'
      - File
    doc: ISOTOPE.DAT data file (isotope abundances)
    inputBinding:
      position: 1
      prefix: -isotope_data
  - id: max_features
    type:
      - 'null'
      - int
    doc: Maximum number of potential features in an mz_window to solve combinatorially
    inputBinding:
      position: 1
      prefix: -max_features
  - id: molecule_max_mz
    type:
      - 'null'
      - float
    doc: Maximum m/z of the molecule models to build
    inputBinding:
      position: 1
      prefix: -molecule_max_mz
  - id: ms_level
    type:
      - 'null'
      - int
    doc: "Spectrum level to analyze: 1 = MS1, 2 = MS2, 3 = MS3, 0 = all"
    inputBinding:
      position: 1
      prefix: -ms_level
  - id: mz_max
    type:
      - 'null'
      - float
    doc: Upper bound of the spectrum m/z range to analyze, 0 = off
    inputBinding:
      position: 1
      prefix: -mz_max
  - id: mz_min
    type:
      - 'null'
      - float
    doc: Lower bound of the spectrum m/z range to analyze, 0 = off
    inputBinding:
      position: 1
      prefix: -mz_min
  - id: mz_window
    type:
      - 'null'
      - float
    doc: Largest m/z window used to split the spectrum (Version1 algorithm)
    inputBinding:
      position: 1
      prefix: -mz_window
  - id: resolution
    type:
      - 'null'
      - float
    doc: Resolution at 400 m/z
    inputBinding:
      position: 1
      prefix: -resolution
  - id: scan_range_max
    type:
      - 'null'
      - int
    doc: Ignore spectra with a scan number higher than this, 0 = off
    inputBinding:
      position: 1
      prefix: -scan_range_max
  - id: scan_range_min
    type:
      - 'null'
      - int
    doc: Ignore spectra with a scan number lower than this, 0 = off
    inputBinding:
      position: 1
      prefix: -scan_range_min
  - id: sensitivity
    type:
      - 'null'
      - int
    doc: Sensitivity level from 0 (lowest) to 3 (highest)
    inputBinding:
      position: 1
      prefix: -sensitivity
  - id: signal_to_noise
    type:
      - 'null'
      - float
    doc: Signal-to-noise ratio cutoff, 0 = off
    inputBinding:
      position: 1
      prefix: -signal_to_noise
  - id: smooth
    type:
      - 'null'
      - int
    doc: Savitzky-Golay smoothing of peak data, 0 = off
    inputBinding:
      position: 1
      prefix: -smooth
  - id: sn_window
    type:
      - 'null'
      - float
    doc: Size in m/z of the window used to compute the local noise level
    inputBinding:
      position: 1
      prefix: -sn_window
  - id: static_sn
    type:
      - 'null'
      - int
    doc: "Apply the lowest local noise level to the whole spectrum: 0 = off, 1 = on"
    inputBinding:
      position: 1
      prefix: -static_sn
  - id: xml
    type:
      - 'null'
      - int
    doc: "Write results as XML: 0 = off, 1 = on"
    inputBinding:
      position: 1
      prefix: -xml
outputs:
  - id: output_file
    type: File
    doc: Hardklor feature list
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hardklor:2.3.2--h503566f_6
