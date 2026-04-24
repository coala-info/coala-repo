cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux xlink-score-spectrum
label: crux_xlink-score-spectrum
doc: "Score cross-linked peptides based on their mass spectrum.\n\nTool homepage:
  https://github.com/redbadger/crux"
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
  - id: use_a_ions
    type:
      - 'null'
      - boolean
    doc: Consider a-ions in the search? Note that an a-ion is equivalent to a 
      neutral loss of CO from the b-ion. Peak height is 10 (in arbitrary units).
    inputBinding:
      position: 109
      prefix: --use-a-ions
  - id: use_b_ions
    type:
      - 'null'
      - boolean
    doc: Consider b-ions in the search? Peak height is 50 (in arbitrary units).
    inputBinding:
      position: 109
      prefix: --use-b-ions
  - id: use_c_ions
    type:
      - 'null'
      - boolean
    doc: Consider c-ions in the search? Peak height is 50 (in arbitrary units).
    inputBinding:
      position: 109
      prefix: --use-c-ions
  - id: use_flanking_peaks
    type:
      - 'null'
      - boolean
    doc: Include flanking peaks around singly charged b and y theoretical ions. 
      Each flanking peak occurs in the adjacent m/z bin and has half the 
      intensity of the primary peak.
    inputBinding:
      position: 109
      prefix: --use-flanking-peaks
  - id: use_x_ions
    type:
      - 'null'
      - boolean
    doc: Consider x-ions in the search? Peak height is 10 (in arbitrary units).
    inputBinding:
      position: 109
      prefix: --use-x-ions
  - id: use_y_ions
    type:
      - 'null'
      - boolean
    doc: Consider y-ions in the search? Peak height is 50 (in arbitrary units).
    inputBinding:
      position: 109
      prefix: --use-y-ions
  - id: use_z_ions
    type:
      - 'null'
      - boolean
    doc: Consider z-ions in the search? Peak height is 50 (in arbitrary units).
    inputBinding:
      position: 109
      prefix: --use-z-ions
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    inputBinding:
      position: 109
      prefix: --verbosity
  - id: xlink_score_method
    type:
      - 'null'
      - string
    doc: Score method for xlink {composite, modification, concatenated}.
    inputBinding:
      position: 109
      prefix: --xlink-score-method
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_xlink-score-spectrum.out
