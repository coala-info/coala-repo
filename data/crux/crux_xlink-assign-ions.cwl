cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux xlink-assign-ions
label: crux_xlink-assign-ions
doc: "Assigns cross-linked peptides to MS/MS spectra.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: peptide_a
    type: string
    doc: The sequence of peptide A.
    inputBinding:
      position: 1
  - id: peptide_b
    type: string
    doc: The sequence of peptide B.
    inputBinding:
      position: 2
  - id: pos_a
    type: int
    doc: Position of cross-link on peptide A
    inputBinding:
      position: 3
  - id: pos_b
    type: int
    doc: Position of cross-link on peptide B
    inputBinding:
      position: 4
  - id: link_mass
    type: float
    doc: The mass modification of the linker when attached to a peptide.
    inputBinding:
      position: 5
  - id: charge_state
    type: int
    doc: The charge state of the peptide.
    inputBinding:
      position: 6
  - id: scan_number
    type: int
    doc: Scan number identifying the spectrum.
    inputBinding:
      position: 7
  - id: ms2_file
    type:
      type: array
      items: File
    doc: The name of one or more files from which to parse the fragmentation 
      spectra, in any of the file formats supported by ProteoWizard.
    inputBinding:
      position: 8
  - id: fragment_mass
    type:
      - 'null'
      - string
    doc: Specify which isotopes to use in calculating fragment ion mass.
    default: mono
    inputBinding:
      position: 109
      prefix: --fragment-mass
  - id: max_ion_charge
    type:
      - 'null'
      - string
    doc: Predict theoretical ions up to max charge state (1, 2, ... ,6) or up to
      the charge state of the peptide ("peptide"). If the max-ion-charge is 
      greater than the charge state of the peptide, then the maximum is the 
      peptide charge.
    default: peptide
    inputBinding:
      position: 109
      prefix: --max-ion-charge
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
    default: 1.0005079
    inputBinding:
      position: 109
      prefix: --mz-bin-width
  - id: precision
    type:
      - 'null'
      - int
    doc: Set the precision for scores written to sqt and text files.
    default: 8
    inputBinding:
      position: 109
      prefix: --precision
  - id: spectrum_parser
    type:
      - 'null'
      - string
    doc: Specify the parser to use for reading in MS/MS spectra.
    default: pwiz
    inputBinding:
      position: 109
      prefix: --spectrum-parser
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
      position: 109
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_xlink-assign-ions.out
