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
    inputBinding:
      position: 101
      prefix: LC=
  - id: max
    type:
      - 'null'
      - int
    doc: Maximum number of foldings to be computed
    inputBinding:
      position: 101
      prefix: MAX=
  - id: max_as
    type:
      - 'null'
      - int
    doc: Maximum asymmetry of a bulge/interior loop
    inputBinding:
      position: 101
      prefix: MAX_AS=
  - id: max_lp
    type:
      - 'null'
      - int
    doc: Maximum bulge/interior loop size
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
    inputBinding:
      position: 101
      prefix: MG_CONC=
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Structure display mode: auto, bases or lines'
    inputBinding:
      position: 101
      prefix: MODE=
  - id: na
    type:
      - 'null'
      - string
    doc: 'Nucleic acid type: RNA or DNA'
    inputBinding:
      position: 101
      prefix: NA=
  - id: na_conc
    type:
      - 'null'
      - float
    doc: Na+ molar concentration
    inputBinding:
      position: 101
      prefix: NA_CONC=
  - id: p
    type:
      - 'null'
      - int
    doc: Percent optimality
    inputBinding:
      position: 101
      prefix: P=
  - id: reuse
    type:
      - 'null'
      - string
    doc: Reuse existing .sav file (NO/YES)
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
    inputBinding:
      position: 101
      prefix: START=
  - id: stop
    type:
      - 'null'
      - string
    doc: 3' base number
    inputBinding:
      position: 101
      prefix: STOP=
  - id: t
    type:
      - 'null'
      - float
    doc: Temperature in degrees C
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
