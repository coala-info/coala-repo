cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux get-ms2-spectrum
label: crux_get-ms2-spectrum
doc: "Parse fragmentation spectra from MS2 files.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: ms2_file
    type:
      type: array
      items: File
    doc: The name of one or more files from which to parse the fragmentation 
      spectra, in any of the file formats supported by ProteoWizard.
    inputBinding:
      position: 1
  - id: remove_precursor_tolerance
    type:
      - 'null'
      - float
    doc: This parameter specifies the tolerance (in Th) around each precursor 
      m/z that is removed when the --remove-precursor-peak option is invoked.
    default: 1.5
    inputBinding:
      position: 102
      prefix: --remove-precursor-tolerance
  - id: scan_number
    type:
      - 'null'
      - string
    doc: A single scan number or a range of numbers to be searched. Range should
      be specified as 'first-last' which will include scans 'first' and 'last'.
    default: ''
    inputBinding:
      position: 102
      prefix: --scan-number
  - id: spectrum_parser
    type:
      - 'null'
      - string
    doc: Specify the parser to use for reading in MS/MS spectra.
    default: pwiz
    inputBinding:
      position: 102
      prefix: --spectrum-parser
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Rather than the spectrum, output summary statistics to standard output.
      Each statistic is placed on a separate line, in the format <name>:<value> 
      (e.g. "TIC:1000.0").
    default: false
    inputBinding:
      position: 102
      prefix: --stats
  - id: use_z_line
    type:
      - 'null'
      - boolean
    doc: Specify whether, when parsing an MS2 spectrum file, Crux obtains the 
      precursor mass information from the "S" line or the "Z" line.
    default: true
    inputBinding:
      position: 102
      prefix: --use-z-line
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
stdout: crux_get-ms2-spectrum.out
