cwlVersion: v1.2
class: CommandLineTool
baseCommand: RNAcofold
label: viennarna_RNAcofold
doc: "The RNAcofold program calculates the secondary structure of two RNA molecules
  upon dimerization. It works much like RNAfold, but the input consists of two sequences
  separated by a '&' character. It can calculate the minimum free energy (MFE) structure
  and, optionally, the partition function and base pairing probabilities.\n\nTool
  homepage: http://www.tbi.univie.ac.at/RNA/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file containing two RNA sequences separated by a '&'. If omitted, reads
      from stdin.
    inputBinding:
      position: 1
  - id: all_pf
    type:
      - 'null'
      - boolean
    doc: Compute the partition function for all possible dimer species (AA, BB, AB).
    inputBinding:
      position: 102
      prefix: --all-pf
  - id: constraint
    type:
      - 'null'
      - File
    doc: Calculate structures subject to constraints.
    inputBinding:
      position: 102
      prefix: --constraint
  - id: dangles
    type:
      - 'null'
      - int
    doc: How to treat dangling end energies (0, 1, 2, or 3).
    default: 2
    inputBinding:
      position: 102
      prefix: --dangles
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: Produce structures without lonely pairs (isolated base pairs).
    inputBinding:
      position: 102
      prefix: --noLP
  - id: no_ps
    type:
      - 'null'
      - boolean
    doc: Do not produce postscript drawing of the secondary structure.
    inputBinding:
      position: 102
      prefix: --noPS
  - id: partition_function
    type:
      - 'null'
      - boolean
    doc: Calculate the partition function and base pairing probability matrix.
    inputBinding:
      position: 102
      prefix: --partfunc
  - id: temp
    type:
      - 'null'
      - float
    doc: Rescale energy parameters to a specific temperature in Celsius.
    default: 37.0
    inputBinding:
      position: 102
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: viennarna_RNAcofold.out
