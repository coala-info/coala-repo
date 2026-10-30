cwlVersion: v1.2
class: CommandLineTool
baseCommand: freefix
label: tinker_freefix
doc: "Tinker free energy of a harmonic (flat-bottom) or Boresch restraint: calculates the analytical volume integral and the restraint free energy, entropy and enthalpy.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: restraint_type
    type: string
    doc: "Restraint type: H harmonic (flat-bottom) restraint or B Boresch restraint"
    default: "H"
    inputBinding:
      position: 1
  - id: inner_radius
    type:
      - 'null'
      - float
    doc: "Harmonic: inner flat-bottom radius in Angstroms"
    inputBinding:
      position: 2
  - id: inner_force_constant
    type:
      - 'null'
      - float
    doc: "Harmonic: inner force constant in kcal/mole/A^2"
    inputBinding:
      position: 3
  - id: outer_radius
    type:
      - 'null'
      - float
    doc: "Harmonic: outer flat-bottom radius in Angstroms"
    inputBinding:
      position: 4
  - id: outer_force_constant
    type:
      - 'null'
      - float
    doc: "Harmonic: outer force constant in kcal/mole/A^2"
    inputBinding:
      position: 5
  - id: temperature
    type:
      - 'null'
      - float
    doc: "Harmonic: system temperature in K"
    inputBinding:
      position: 6
  - id: boresch_values
    type:
      - 'null'
      - float[]
    doc: "Boresch: distance, distance force constant, angle 1, angle 1 force constant, angle 2, angle 2 force constant, torsion 1, 2 and 3 force constants and temperature (ten numbers in this order)"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_freefix.out
