cwlVersion: v1.2
class: CommandLineTool
baseCommand: constava dihedrals
label: constava_dihedrals
doc: "The `constava dihedrals` submodule is used to extract the backbone dihedrals
  needed for the analysis from conformational ensembles. By default the results are
  written out in radians as this is the preferred format for `constava analyze`.\n\
  \nNote: For the first and last residue in a protein only one backbone dihedral can
  be extracted. Thus, those residues are omitted by default.\n\nTool homepage: https://github.com/bio2byte/constava"
inputs:
  - id: degrees
    type:
      - 'null'
      - boolean
    doc: If set results are written in degrees instead of radians.
    inputBinding:
      position: 101
      prefix: --degrees
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: If set any previously generated output will be overwritten.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: precision
    type:
      - 'null'
      - int
    doc: Defines the number of decimals written for the dihedrals.
    inputBinding:
      position: 101
      prefix: --precision
  - id: selection
    type:
      - 'null'
      - string
    doc: Selection for the dihedral calculation.
    inputBinding:
      position: 101
      prefix: --selection
  - id: structure
    type:
      - 'null'
      - File
    doc: 'Structure file with atomic information: [pdb, gro, tpr]'
    inputBinding:
      position: 101
      prefix: --structure
  - id: trajectory
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Trajectory file with coordinates: [pdb, gro, trr, xtc, crd, nc]'
    inputBinding:
      position: 101
      prefix: --trajectory
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: CSV file to write dihedral information to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
