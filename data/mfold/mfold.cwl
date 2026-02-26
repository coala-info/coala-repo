cwlVersion: v1.2
class: CommandLineTool
baseCommand: mfold
label: mfold
doc: "Predicts RNA or DNA secondary structure using thermodynamic methods\n\nTool
  homepage: http://www.unafold.org/mfold/software/download-mfold.php"
inputs:
  - id: ann
    type:
      - 'null'
      - string
    doc: 'Structure annotation type: none, p-num or ss-count'
    default: none
    inputBinding:
      position: 101
      prefix: ANN=
  - id: aux
    type:
      - 'null'
      - File
    doc: Auxiliary file name
    inputBinding:
      position: 101
      prefix: AUX=
  - id: lab_fr
    type:
      - 'null'
      - int
    doc: Base numbering frequency
    inputBinding:
      position: 101
      prefix: LAB_FR=
  - id: lc
    type:
      - 'null'
      - string
    doc: Sequence type (linear or circular)
    default: linear
    inputBinding:
      position: 101
      prefix: LC=
  - id: max
    type:
      - 'null'
      - int
    doc: Maximum number of foldings to be computed
    default: 100
    inputBinding:
      position: 101
      prefix: MAX=
  - id: max_as
    type:
      - 'null'
      - int
    doc: Maximum asymmetry of a bulge/interior loop
    default: 30
    inputBinding:
      position: 101
      prefix: MAX_AS=
  - id: max_lp
    type:
      - 'null'
      - int
    doc: Maximum bulge/interior loop size
    default: 30
    inputBinding:
      position: 101
      prefix: MAX_LP=
  - id: maxbp
    type:
      - 'null'
      - int
    doc: Maximum base pair distance
    inputBinding:
      position: 101
      prefix: MAXBP=
  - id: mg_conc
    type:
      - 'null'
      - float
    doc: Mg++ molar concentration
    default: 0.0
    inputBinding:
      position: 101
      prefix: MG_CONC=
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Structure display mode: auto, bases or lines'
    default: auto
    inputBinding:
      position: 101
      prefix: MODE=
  - id: na
    type:
      - 'null'
      - string
    doc: 'Nucleic acid type: RNA or DNA'
    default: RNA
    inputBinding:
      position: 101
      prefix: NA=
  - id: na_conc
    type:
      - 'null'
      - float
    doc: Na+ molar concentration
    default: 1.0
    inputBinding:
      position: 101
      prefix: NA_CONC=
  - id: p
    type:
      - 'null'
      - int
    doc: Percent optimality
    default: 5
    inputBinding:
      position: 101
      prefix: P=
  - id: reuse
    type:
      - 'null'
      - string
    doc: Reuse existing .sav file (NO/YES)
    default: NO
    inputBinding:
      position: 101
      prefix: REUSE=
  - id: rot_ang
    type:
      - 'null'
      - int
    doc: Structure rotation angle
    inputBinding:
      position: 101
      prefix: ROT_ANG=
  - id: run_type
    type:
      - 'null'
      - string
    doc: 'Run type: text or html'
    default: text
    inputBinding:
      position: 101
      prefix: RUN_TYPE=
  - id: seq
    type: File
    doc: Input sequence file name
    inputBinding:
      position: 101
      prefix: SEQ=
  - id: start
    type:
      - 'null'
      - int
    doc: 5' base number
    default: 1
    inputBinding:
      position: 101
      prefix: START=
  - id: stop
    type:
      - 'null'
      - string
    doc: 3' base number
    default: end
    inputBinding:
      position: 101
      prefix: STOP=
  - id: t
    type:
      - 'null'
      - float
    doc: Temperature in degrees C
    default: 37.0
    inputBinding:
      position: 101
      prefix: T=
  - id: w
    type:
      - 'null'
      - int
    doc: Window parameter (default set by sequence length)
    inputBinding:
      position: 101
      prefix: W=
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mfold:3.6--h8537716_3
stdout: mfold.out
