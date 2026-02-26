cwlVersion: v1.2
class: CommandLineTool
baseCommand: privateer
label: privateer
doc: "Privateer Version MKV. Copyright 2013-2024 Jon Agirre (@glycojones) & University
  of York.\n\nTool homepage: https://github.com/glycojones/privateer"
inputs:
  - id: cifin
    type:
      - 'null'
      - File
    doc: mmCIF or MTZ file with merged I or F (needed for RSCC)
    inputBinding:
      position: 101
      prefix: -cifin
  - id: codein
    type:
      - 'null'
      - string
    doc: A 3-letter code (should match that in -valstring)
    inputBinding:
      position: 101
      prefix: -codein
  - id: colin_fo
    type:
      - 'null'
      - string
    doc: Columns containing F & SIGF, e.g. FOBS,SIGFOBS
    inputBinding:
      position: 101
      prefix: -colin-fo
  - id: essentials
    type:
      - 'null'
      - boolean
    doc: Control SNFG glycan plot output (SVG graphics)
    inputBinding:
      position: 101
      prefix: -essentials
  - id: expression
    type:
      - 'null'
      - string
    doc: Specify which expression system the input glycoprotein was produced in
    inputBinding:
      position: 101
      prefix: -expression
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Control SNFG glycan plot output (SVG graphics)
    inputBinding:
      position: 101
      prefix: -invert
  - id: list
    type:
      - 'null'
      - boolean
    doc: Produces a list of space-separated supported 3-letter codes and stops
    inputBinding:
      position: 101
      prefix: -list
  - id: mode
    type:
      - 'null'
      - string
    doc: Run mode (def:normal). ccp4i2 mode produces XML and CSV files
    default: normal
    inputBinding:
      position: 101
      prefix: -mode
  - id: mtzin
    type:
      - 'null'
      - File
    doc: mmCIF or MTZ file with merged I or F (needed for RSCC)
    inputBinding:
      position: 101
      prefix: -mtzin
  - id: pdbin
    type: File
    doc: input model in PDB or mmCIF format
    inputBinding:
      position: 101
      prefix: -pdbin
  - id: radiusin
    type:
      - 'null'
      - float
    doc: A radius (def:2.5)for the calculation of a mask around the target 
      monosaccharide
    default: 2.5
    inputBinding:
      position: 101
      prefix: -radiusin
  - id: rscc_best
    type:
      - 'null'
      - boolean
    doc: Calculate RSCC against best omit density (Fobs used by default)
    inputBinding:
      position: 101
      prefix: -rscc-best
  - id: showgeom
    type:
      - 'null'
      - boolean
    doc: Ring bond lengths, angles and torsions are reported clockwise
    inputBinding:
      position: 101
      prefix: -showgeom
  - id: valstring
    type:
      - 'null'
      - string
    doc: Use external validation options (to be deprecated in MKV)
    inputBinding:
      position: 101
      prefix: -valstring
  - id: vertical
    type:
      - 'null'
      - boolean
    doc: Control SNFG glycan plot output (SVG graphics)
    inputBinding:
      position: 101
      prefix: -vertical
outputs:
  - id: mtzout
    type:
      - 'null'
      - File
    doc: Output best and difference map coefficients to MTZ files
    outputBinding:
      glob: $(inputs.mtzout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/privateer:MKV--py311h8d1dbc1_0
