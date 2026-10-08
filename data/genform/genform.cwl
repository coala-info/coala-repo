cwlVersion: v1.2
class: CommandLineTool
baseCommand: genform
label: genform
doc: "Formula calculation from MS and MS/MS data as described in Meringer et al (2011)
  MATCH Commun Math Comput Chem 65: 259-290. All options use the key=value form of
  the program.\n\nTool homepage: https://sourceforge.net/projects/genform/"
inputs:
  - id: ms_file
    type:
      - File
    doc: "Filename of MS data (*.txt; m/z and intensity per line)."
    inputBinding:
      position: 101
      prefix: ms=
      separate: false
  - id: msms_file
    type:
      - 'null'
      - File
    doc: "Filename of MS/MS data (*.txt)."
    inputBinding:
      position: 101
      prefix: msms=
      separate: false
  - id: out_name
    type:
      - 'null'
      - string
    doc: "Output file with the generated formulas (standard output otherwise)."
    inputBinding:
      position: 101
      prefix: out=
      separate: false
  - id: exist
    type:
      - 'null'
      - boolean
    doc: "Allow only molecular formulas for that at least one structural formula exists; overrides vsp, vsm2mv, vsm2ap2."
    inputBinding:
      position: 101
      prefix: exist
  - id: exist_mv
    type:
      - 'null'
      - boolean
    doc: "Same as exist, and enables multiple valencies for P and S (exist=mv)."
    inputBinding:
      position: 101
      prefix: exist=mv
  - id: mass
    type:
      - 'null'
      - float
    doc: "Experimental molecular mass (default: mass of MS basepeak)."
    inputBinding:
      position: 101
      prefix: m=
      separate: false
  - id: ion
    type:
      - 'null'
      - string
    doc: "Type of ion measured: -e, +e, -H, +H or +Na (default: M+H)."
    inputBinding:
      position: 101
      prefix: ion=
      separate: false
  - id: charge
    type:
      - 'null'
      - int
    doc: "Charge of the ion."
    inputBinding:
      position: 101
      prefix: cha=
      separate: false
  - id: ppm
    type:
      - 'null'
      - float
    doc: "Accuracy of measurement in parts per million (default: 5)."
    inputBinding:
      position: 101
      prefix: ppm=
      separate: false
  - id: msmv
    type:
      - 'null'
      - string
    doc: "MS match value based on normalized dot product (ndp), normalized sum of squared errors (nsse) or absolute errors (nsae); default nsae."
    inputBinding:
      position: 101
      prefix: msmv=
      separate: false
  - id: acc
    type:
      - 'null'
      - float
    doc: "Allowed deviation for full acceptance of MS/MS peak in ppm (default: 2)."
    inputBinding:
      position: 101
      prefix: acc=
      separate: false
  - id: rej
    type:
      - 'null'
      - float
    doc: "Allowed deviation for total rejection of MS/MS peak in ppm (default: 4)."
    inputBinding:
      position: 101
      prefix: rej=
      separate: false
  - id: thms
    type:
      - 'null'
      - float
    doc: "Threshold for the MS match value."
    inputBinding:
      position: 101
      prefix: thms=
      separate: false
  - id: thmsms
    type:
      - 'null'
      - float
    doc: "Threshold for the MS/MS match value."
    inputBinding:
      position: 101
      prefix: thmsms=
      separate: false
  - id: thcomb
    type:
      - 'null'
      - float
    doc: "Threshold for the combined match value."
    inputBinding:
      position: 101
      prefix: thcomb=
      separate: false
  - id: sort
    type:
      - 'null'
      - boolean
    doc: "Sort generated formulas according to mass deviation in ppm."
    inputBinding:
      position: 101
      prefix: sort
  - id: sort_by
    type:
      - 'null'
      - string
    doc: "Sort generated formulas by ppm, msmv, msmsmv or combmv (sort=<value>)."
    inputBinding:
      position: 101
      prefix: sort=
      separate: false
  - id: elements
    type:
      - 'null'
      - string
    doc: "Used chemical elements (default: CHBrClFINOPSSi)."
    inputBinding:
      position: 101
      prefix: el=
      separate: false
  - id: only_organic
    type:
      - 'null'
      - boolean
    doc: "Only organic compounds, i.e. with at least one C atom (use with el)."
    inputBinding:
      position: 101
      prefix: oc
  - id: fuzzy_formula
    type:
      - 'null'
      - string
    doc: "Fuzzy formula for limits of element multiplicities; overwrites el and oc."
    inputBinding:
      position: 101
      prefix: ff=
      separate: false
  - id: hetero
    type:
      - 'null'
      - boolean
    doc: "Formulas must have at least one hetero atom."
    inputBinding:
      position: 101
      prefix: het
  - id: vsp
    type:
      - 'null'
      - boolean
    doc: "Valency sum parity (even for graphical formulas)."
    inputBinding:
      position: 101
      prefix: vsp
  - id: vsp_value
    type:
      - 'null'
      - string
    doc: "Valency sum parity: even or odd (vsp=<value>)."
    inputBinding:
      position: 101
      prefix: vsp=
      separate: false
  - id: vsm2mv
    type:
      - 'null'
      - boolean
    doc: "Lower bound for valency sum - 2 * maximum valency."
    inputBinding:
      position: 101
      prefix: vsm2mv
  - id: vsm2mv_value
    type:
      - 'null'
      - float
    doc: "Lower bound for valency sum - 2 * maximum valency (>=0 for graphical formulas)."
    inputBinding:
      position: 101
      prefix: vsm2mv=
      separate: false
  - id: vsm2ap2
    type:
      - 'null'
      - boolean
    doc: "Lower bound for valency sum - 2 * number of atoms + 2."
    inputBinding:
      position: 101
      prefix: vsm2ap2
  - id: vsm2ap2_value
    type:
      - 'null'
      - float
    doc: "Lower bound for valency sum - 2 * number of atoms + 2 (>=0 for graphical connected formulas)."
    inputBinding:
      position: 101
      prefix: vsm2ap2=
      separate: false
  - id: hcf
    type:
      - 'null'
      - boolean
    doc: "Apply Heuerding-Clerc filter."
    inputBinding:
      position: 101
      prefix: hcf
  - id: wm
    type:
      - 'null'
      - boolean
    doc: "Weight m/z for the MS/MS match value (linear)."
    inputBinding:
      position: 101
      prefix: wm
  - id: wm_value
    type:
      - 'null'
      - string
    doc: "m/z weighting for MS/MS match value: lin, sqrt or log."
    inputBinding:
      position: 101
      prefix: wm=
      separate: false
  - id: wi
    type:
      - 'null'
      - boolean
    doc: "Weight intensity for the MS/MS match value (linear)."
    inputBinding:
      position: 101
      prefix: wi
  - id: wi_value
    type:
      - 'null'
      - string
    doc: "Intensity weighting for MS/MS match value: lin, sqrt or log."
    inputBinding:
      position: 101
      prefix: wi=
      separate: false
  - id: exp
    type:
      - 'null'
      - float
    doc: "Exponent used when wi is set to log."
    inputBinding:
      position: 101
      prefix: exp=
      separate: false
  - id: oei
    type:
      - 'null'
      - boolean
    doc: "Allow odd electron ions for explaining MS/MS peaks."
    inputBinding:
      position: 101
      prefix: oei
  - id: dbeexc
    type:
      - 'null'
      - float
    doc: "Excess of double bond equivalent for ions."
    inputBinding:
      position: 101
      prefix: dbeexc=
      separate: false
  - id: ivsm2mv
    type:
      - 'null'
      - float
    doc: "Lower bound for valency sum - 2 * maximum valency for fragment ions."
    inputBinding:
      position: 101
      prefix: ivsm2mv=
      separate: false
  - id: ivsm2ap2
    type:
      - 'null'
      - float
    doc: "Lower bound for valency sum - 2 * number of atoms + 2 for fragment ions."
    inputBinding:
      position: 101
      prefix: ivsm2ap2=
      separate: false
  - id: oms_name
    type:
      - 'null'
      - string
    doc: "Write scaled MS peaks to this output file."
    inputBinding:
      position: 101
      prefix: oms=
      separate: false
  - id: omsms_name
    type:
      - 'null'
      - string
    doc: "Write weighted MS/MS peaks to this output file."
    inputBinding:
      position: 101
      prefix: omsms=
      separate: false
  - id: oclean_name
    type:
      - 'null'
      - string
    doc: "Write explained MS/MS peaks to this output file."
    inputBinding:
      position: 101
      prefix: oclean=
      separate: false
  - id: analyze
    type:
      - 'null'
      - boolean
    doc: "Write explanations for MS/MS peaks to output."
    inputBinding:
      position: 101
      prefix: analyze
  - id: loss
    type:
      - 'null'
      - boolean
    doc: "For analyzing MS/MS peaks write losses instead of fragments (use with analyze)."
    inputBinding:
      position: 101
      prefix: loss
  - id: intens
    type:
      - 'null'
      - boolean
    doc: "Write intensities of MS/MS peaks to output (use with analyze)."
    inputBinding:
      position: 101
      prefix: intens
  - id: dbe
    type:
      - 'null'
      - boolean
    doc: "Write double bond equivalents to output."
    inputBinding:
      position: 101
      prefix: dbe
  - id: cm
    type:
      - 'null'
      - boolean
    doc: "Write calculated ion masses to output."
    inputBinding:
      position: 101
      prefix: cm
  - id: pc
    type:
      - 'null'
      - boolean
    doc: "Output match values in percent."
    inputBinding:
      position: 101
      prefix: pc
  - id: sc
    type:
      - 'null'
      - boolean
    doc: "Strip calculated isotope distributions."
    inputBinding:
      position: 101
      prefix: sc
  - id: noref
    type:
      - 'null'
      - boolean
    doc: "Hide the reference information."
    inputBinding:
      position: 101
      prefix: noref
outputs:
  - id: stdout
    type: stdout
    doc: "Generated formulas (standard output when out is not given)."
  - id: out_file
    type:
      - 'null'
      - File
    doc: "Output file with the generated formulas."
    outputBinding:
      glob: $(inputs.out_name)
  - id: oms_file
    type:
      - 'null'
      - File
    doc: "Scaled MS peaks."
    outputBinding:
      glob: $(inputs.oms_name)
  - id: omsms_file
    type:
      - 'null'
      - File
    doc: "Weighted MS/MS peaks."
    outputBinding:
      glob: $(inputs.omsms_name)
  - id: oclean_file
    type:
      - 'null'
      - File
    doc: "Explained MS/MS peaks."
    outputBinding:
      glob: $(inputs.oclean_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genform:r8--h9948957_8
stdout: genform.out
