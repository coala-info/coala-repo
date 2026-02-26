cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crux
  - bullseye
label: crux_bullseye
doc: "Bullseye will search for PPIDs in these spectra. Bullseye will assign high-resolution
  precursor masses to these spectra.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: ms1_spectra
    type: File
    doc: The name of a file from which to parse high-resolution spectra of 
      intact peptides. The file may be in MS1 (.ms1), binary MS1 (.bms1), 
      compressed MS1 (.cms1), or mzXML (.mzXML) format. Bullseye will search for
      PPIDs in these spectra.
    inputBinding:
      position: 1
  - id: ms2_spectra
    type: File
    doc: The name of a file from which to parse peptide fragmentation spectra. 
      The file may be in MS2 (.ms2), binary MS2 (.bms2), compressed MS2 (.cms2) 
      or mzXML (.mzXML) format. Bullseye will assign high-resolution precursor 
      masses to these spectra.
    inputBinding:
      position: 2
  - id: bullseye_max_mass
    type:
      - 'null'
      - float
    doc: Only consider PPIDs below this maximum mass in daltons.
    default: 8000.0
    inputBinding:
      position: 103
      prefix: --bullseye-max-mass
  - id: bullseye_min_mass
    type:
      - 'null'
      - float
    doc: Only consider PPIDs above this minimum mass in daltons.
    default: 600.0
    inputBinding:
      position: 103
      prefix: --bullseye-min-mass
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
    default: false
    inputBinding:
      position: 103
      prefix: --exact-match
  - id: exact_tolerance
    type:
      - 'null'
      - float
    doc: Set the tolerance (+/-ppm) for --exact-match.
    default: 10.0
    inputBinding:
      position: 103
      prefix: --exact-tolerance
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    default: ''
    inputBinding:
      position: 103
      prefix: --fileroot
  - id: gap_tolerance
    type:
      - 'null'
      - int
    doc: Allowed gap size when checking for PPIDs across consecutive MS1 scans.
    default: 1
    inputBinding:
      position: 103
      prefix: --gap-tolerance
  - id: max_persist
    type:
      - 'null'
      - float
    doc: Ignore PPIDs that persist for longer than this length of time in the 
      MS1 spectra. The unit of time is whatever unit is used in your data file 
      (usually minutes). These PPIDs are considered contaminants.
    default: 2.0
    inputBinding:
      position: 103
      prefix: --max-persist
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    default: crux-output
    inputBinding:
      position: 103
      prefix: --output-dir
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
  - id: persist_tolerance
    type:
      - 'null'
      - float
    doc: Set the mass tolerance (+/-ppm) for finding PPIDs in consecutive MS1 
      scans.
    default: 10.0
    inputBinding:
      position: 103
      prefix: --persist-tolerance
  - id: retention_tolerance
    type:
      - 'null'
      - float
    doc: Set the tolerance (+/-units) around the retention time over which a 
      PPID can be matches to the MS2 spectrum. The unit of time is whatever unit
      is used in your data file (usually minutes).
    default: 0.5
    inputBinding:
      position: 103
      prefix: --retention-tolerance
  - id: scan_tolerance
    type:
      - 'null'
      - int
    doc: Total number of MS1 scans over which a PPID must be observed to be 
      considered real. Gaps in persistence are allowed by setting 
      --gap-tolerance.
    default: 3
    inputBinding:
      position: 103
      prefix: --scan-tolerance
  - id: spectrum_format
    type:
      - 'null'
      - string
    doc: The format to write the output spectra to. If empty, the spectra will 
      be output in the same format as the MS2 input.
    default: ''
    inputBinding:
      position: 103
      prefix: --spectrum-format
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
stdout: crux_bullseye.out
