cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux predict-peptide-ions
label: crux_predict-peptide-ions
doc: "Predict theoretical peptide ions.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: peptide_sequence
    type: string
    doc: The peptide sequence.
    inputBinding:
      position: 1
  - id: charge_state
    type: string
    doc: The charge state of the peptide.
    inputBinding:
      position: 2
  - id: flanking
    type:
      - 'null'
      - boolean
    doc: Predict flanking peaks for b- and y ions.
    default: false
    inputBinding:
      position: 103
      prefix: --flanking
  - id: fragment_mass
    type:
      - 'null'
      - string
    doc: Specify which isotopes to use in calculating fragment ion mass.
    default: mono
    inputBinding:
      position: 103
      prefix: --fragment-mass
  - id: h2o
    type:
      - 'null'
      - int
    doc: Include in the predicted peaks, b/y ions with the loss of 1 to n water 
      molecules. See --nh3 for an example.
    default: 0
    inputBinding:
      position: 103
      prefix: --h2o
  - id: isotope
    type:
      - 'null'
      - int
    doc: Predict the given number of isotope peaks (0|1|2).
    default: 0
    inputBinding:
      position: 103
      prefix: --isotope
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
      position: 103
      prefix: --max-ion-charge
  - id: nh3
    type:
      - 'null'
      - int
    doc: Include among the predicted peaks b/y ions with up to n losses of nh3. 
      For example, for --nh3 2, predict a peak for each b- and y-ion with the 
      loss of one nh3 group and predict a second peak for each b- and y-ion with
      the loss of two nh3 groups. These peaks will have 1 and 2, respectively, 
      in the NH3 column of the output.
    default: 0
    inputBinding:
      position: 103
      prefix: --nh3
  - id: precursor_ions
    type:
      - 'null'
      - boolean
    doc: Predict the precursor ions, and all associated ions (neutral losses, 
      multiple charge states) consistent with the other specified options.
    default: false
    inputBinding:
      position: 103
      prefix: --precursor-ions
  - id: primary_ions
    type:
      - 'null'
      - string
    doc: Predict the specified primary ion series. 'a' indicates a-ions only, 
      'b' indicates b-ions only, 'y' indicates y-ions only, 'by' indicates both 
      b and y, 'bya' indicates b, y, and a.
    default: by
    inputBinding:
      position: 103
      prefix: --primary-ions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_predict-peptide-ions.out
