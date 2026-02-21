cwlVersion: v1.2
class: CommandLineTool
baseCommand: suitename
label: suitename
doc: "Suitename is a tool that classifies RNA backbone geometry into discrete conformers
  (suites) based on dihedral angles, typically used as part of the MolProbity suite.\n
  \nTool homepage: https://github.com/rlabduke/suitename"
inputs:
  - id: chart
    type:
      - 'null'
      - boolean
    doc: Produce a suite-based chart
    inputBinding:
      position: 101
      prefix: -chart
  - id: kinemage
    type:
      - 'null'
      - boolean
    doc: Produce kinemage markup for visualization
    inputBinding:
      position: 101
      prefix: -kinemage
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: Do not include sequence in the output
    inputBinding:
      position: 101
      prefix: -nosequence
  - id: oneline
    type:
      - 'null'
      - boolean
    doc: Output everything on one line
    inputBinding:
      position: 101
      prefix: -oneline
  - id: report
    type:
      - 'null'
      - boolean
    doc: Produce a one-line-per-residue report (default)
    inputBinding:
      position: 101
      prefix: -report
  - id: residue
    type:
      - 'null'
      - boolean
    doc: Produce residue-based information
    inputBinding:
      position: 101
      prefix: -residue
  - id: string
    type:
      - 'null'
      - boolean
    doc: Produce a one-character-per-residue string
    inputBinding:
      position: 101
      prefix: -string
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run internal tests
    inputBinding:
      position: 101
      prefix: -test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/suitename:v0.3.070628-2-deb_cv1
stdout: suitename.out
