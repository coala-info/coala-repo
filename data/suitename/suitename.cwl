cwlVersion: v1.2
class: CommandLineTool
baseCommand: suitename
label: suitename
doc: "Suitename classifies the conformation of each suite of an RNA backbone into one of the suite conformers from dihedral angles (as made by dangle).\n\nTool homepage: https://github.com/rlabduke/suitename"
inputs:
  - id: input_file
    type: File
    doc: Dihedral angles per residue (dangle output with alpha, beta, gamma, delta, epsilon, zeta), or kinemage point records with -suitein; read from standard input
  - id: report
    type:
      - 'null'
      - boolean
    doc: Output one line per suite in order of input, with a suiteness summary at the end (default)
    inputBinding:
      position: 2
      prefix: -report
  - id: chart
    type:
      - 'null'
      - boolean
    doc: With -report, no summary at the end (for MolProbity multichart)
    inputBinding:
      position: 2
      prefix: -chart
  - id: string
    type:
      - 'null'
      - boolean
    doc: Output a 3 character per suite string in order of input, 20 per line
    inputBinding:
      position: 2
      prefix: -string
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: With -string, only suite names, no base sequence character
    inputBinding:
      position: 2
      prefix: -nosequence
  - id: oneline
    type:
      - 'null'
      - boolean
    doc: With -string, the string is all one line, no point IDs
    inputBinding:
      position: 2
      prefix: -oneline
  - id: overlap
    type:
      - 'null'
      - boolean
    doc: With -string, 20 per line with 10 overlapping each line, 10 new per line
    inputBinding:
      position: 2
      prefix: -overlap
  - id: kinemage
    type:
      - 'null'
      - boolean
    doc: Output a kinemage of clusters grouped by pucker
    inputBinding:
      position: 2
      prefix: -kinemage
  - id: nowannabe
    type:
      - 'null'
      - boolean
    doc: Do not assign to the wannabe clusters
    inputBinding:
      position: 2
      prefix: -nowannabe
  - id: residuein
    type:
      - 'null'
      - boolean
    doc: Input is residue based (default)
    inputBinding:
      position: 2
      prefix: -residuein
  - id: suitein
    type:
      - 'null'
      - boolean
    doc: Input is point records from a kinemage
    inputBinding:
      position: 2
      prefix: -suitein
  - id: pointidfields
    type:
      - 'null'
      - int
    doc: Number of point ID fields with -residuein (default 6)
    inputBinding:
      position: 2
      prefix: -pointIDfields
  - id: anglefields
    type:
      - 'null'
      - int
    doc: Number of angle fields with -suitein (default 9)
    inputBinding:
      position: 2
      prefix: -anglefields
  - id: thetaeta
    type:
      - 'null'
      - boolean
    doc: Kinemage labels theta,eta instead of chi-1,chi
    inputBinding:
      position: 2
      prefix: -thetaeta
  - id: power
    type:
      - 'null'
      - float
    doc: Power of the multi-dimension distance calculation (default 3.00)
    inputBinding:
      position: 2
      prefix: -power
  - id: test
    type:
      - 'null'
      - boolean
    doc: Dump cluster centers and half-widths to standard error
    inputBinding:
      position: 2
      prefix: -test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr_out
    type: stderr
    doc: Standard error (cluster tables with -test)
stdin: $(inputs.input_file.path)
stdout: suitename.out
stderr: suitename.err
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/suitename:v0.3.070628-2-deb_cv1
