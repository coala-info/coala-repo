cwlVersion: v1.2
class: CommandLineTool
baseCommand: genform
label: genform_dbe
doc: "Formula calculation from MS and MS/MS data as described in Meringer et al (2011)
  MATCH Commun Math Comput Chem 65: 259-290\n\nTool homepage: https://sourceforge.net/projects/genform/"
inputs:
  - id: acc
    type:
      - 'null'
      - int
    doc: allowed deviation for full acceptance of MS/MS peak in ppm
    default: 2
    inputBinding:
      position: 101
  - id: analyze
    type:
      - 'null'
      - boolean
    doc: write explanations for MS/MS peaks to output
    inputBinding:
      position: 101
  - id: analyze_intens
    type:
      - 'null'
      - boolean
    doc: write intensities of MS/MS peaks to output
    inputBinding:
      position: 101
  - id: analyze_loss
    type:
      - 'null'
      - boolean
    doc: for analyzing MS/MS peaks write losses instead of fragments
    inputBinding:
      position: 101
  - id: cha
    type:
      - 'null'
      - int
    doc: charge number
    inputBinding:
      position: 101
  - id: cm
    type:
      - 'null'
      - boolean
    doc: write calculated ion masses to output
    inputBinding:
      position: 101
  - id: dbe
    type:
      - 'null'
      - boolean
    doc: write double bond equivalents to output
    inputBinding:
      position: 101
  - id: dbeexc
    type:
      - 'null'
      - float
    doc: excess of double bond equivalent for ions
    inputBinding:
      position: 101
  - id: el
    type:
      - 'null'
      - string
    doc: used chemical elements
    default: CHBrClFINOPSSi
    inputBinding:
      position: 101
  - id: exist
    type:
      - 'null'
      - string
    doc: allow only molecular formulas for that at least one structural formula 
      exists;overrides vsp, vsm2mv, vsm2ap2; argument mv enables multiple 
      valencies for P and S
    inputBinding:
      position: 101
  - id: exp
    type:
      - 'null'
      - float
    doc: exponent used, when wi is set to log
    inputBinding:
      position: 101
  - id: ff
    type:
      - 'null'
      - string
    doc: overwrites el and oc and uses fuzzy formula for limits of element 
      multiplicities
    inputBinding:
      position: 101
  - id: hcf
    type:
      - 'null'
      - boolean
    doc: apply Heuerding-Clerc filter
    inputBinding:
      position: 101
  - id: het
    type:
      - 'null'
      - boolean
    doc: formulas must have at least one hetero atom
    inputBinding:
      position: 101
  - id: ion
    type:
      - 'null'
      - string
    doc: type of ion measured
    default: M+H
    inputBinding:
      position: 101
  - id: ivsm2ap2
    type:
      - 'null'
      - float
    doc: lower bound for valency sum - 2 * number of atoms + 2 for fragment ions
    inputBinding:
      position: 101
  - id: ivsm2mv
    type:
      - 'null'
      - float
    doc: lower bound for valency sum - 2 * maximum valency for fragment ions
    inputBinding:
      position: 101
  - id: m
    type:
      - 'null'
      - float
    doc: experimental molecular mass
    default: mass of MS basepeak
    inputBinding:
      position: 101
  - id: ms
    type: File
    doc: filename of MS data (*.txt)
    inputBinding:
      position: 101
  - id: msms
    type:
      - 'null'
      - File
    doc: filename of MS/MS data (*.txt)
    inputBinding:
      position: 101
  - id: msmv
    type:
      - 'null'
      - string
    doc: MS match value based on normalized dot product, normalized sum of 
      squared or absolute errors
    default: nsae
    inputBinding:
      position: 101
  - id: noref
    type:
      - 'null'
      - boolean
    doc: hide the reference information
    inputBinding:
      position: 101
  - id: oc
    type:
      - 'null'
      - boolean
    doc: only organic compounds, i.e. with at least one C atom
    inputBinding:
      position: 101
  - id: oclean
    type:
      - 'null'
      - File
    doc: write explained MS/MS peaks to output
    inputBinding:
      position: 101
  - id: oei
    type:
      - 'null'
      - boolean
    doc: allow odd electron ions for explaining MS/MS peaks
    inputBinding:
      position: 101
  - id: oms
    type:
      - 'null'
      - File
    doc: write scaled MS peaks to output
    inputBinding:
      position: 101
  - id: omsms
    type:
      - 'null'
      - File
    doc: write weighted MS/MS peaks to output
    inputBinding:
      position: 101
  - id: pc
    type:
      - 'null'
      - boolean
    doc: output match values in percent
    inputBinding:
      position: 101
  - id: ppm
    type:
      - 'null'
      - int
    doc: accuracy of measurement in parts per million
    default: 5
    inputBinding:
      position: 101
  - id: rej
    type:
      - 'null'
      - int
    doc: allowed deviation for total rejection of MS/MS peak in ppm
    default: 4
    inputBinding:
      position: 101
  - id: sc
    type:
      - 'null'
      - boolean
    doc: strip calculated isotope distributions
    inputBinding:
      position: 101
  - id: sort
    type:
      - 'null'
      - string
    doc: sort generated formulas according to mass deviation in ppm, MS match 
      value, MS/MS match value or combined match value
    inputBinding:
      position: 101
  - id: thcomb
    type:
      - 'null'
      - float
    doc: threshold for the combined match value
    inputBinding:
      position: 101
  - id: thms
    type:
      - 'null'
      - float
    doc: threshold for the MS match value
    inputBinding:
      position: 101
  - id: thmsms
    type:
      - 'null'
      - float
    doc: threshold for the MS/MS match value
    inputBinding:
      position: 101
  - id: vsm2ap2
    type:
      - 'null'
      - float
    doc: lower bound for valency sum - 2 * number of atoms + 2 (>=0 for 
      graphical connected formulas)
    inputBinding:
      position: 101
  - id: vsm2mv
    type:
      - 'null'
      - float
    doc: lower bound for valency sum - 2 * maximum valency (>=0 for graphical 
      formulas)
    inputBinding:
      position: 101
  - id: vsp
    type:
      - 'null'
      - string
    doc: valency sum parity (even for graphical formulas)
    inputBinding:
      position: 101
  - id: wi
    type:
      - 'null'
      - string
    doc: intensity weighting for MS/MS match value
    inputBinding:
      position: 101
  - id: wm
    type:
      - 'null'
      - string
    doc: m/z weighting for MS/MS match value
    inputBinding:
      position: 101
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output generated formulas
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genform:r8--h9948957_8
