cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNA2Dfold
label: viennarna_RNA2Dfold
doc: |-
  Compute MFE structure, partition function and representative sample structures of k,l neighborhoods. Reads a sequence and two reference structures from standard input.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: input
    type: File
    doc: Sequence and two secondary structures in dot-bracket notation (one per line).
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Set the number of threads used for calculations (only available when compiled with OpenMP support)
    inputBinding:
      position: 10
      prefix: --numThreads=
      separate: false
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitute nucleotide "T" with "U".
    inputBinding:
      position: 10
      prefix: --noconv
  - id: partfunc
    type:
      - 'null'
      - boolean
    doc: calculate partition function and thus, Boltzmann probabilities and Gibbs free energy
    inputBinding:
      position: 10
      prefix: --partfunc
  - id: stoch_bt
    type:
      - 'null'
      - int
    doc: backtrack a certain number of Boltzmann samples from the appropriate k,l neighborhood(s)
    inputBinding:
      position: 10
      prefix: --stochBT=
      separate: false
  - id: neighborhood
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --neighborhood=
          separate: false
    doc: backtrack structures from certain k,l-neighborhood only, can be specified multiple times (<k>:<l>,<m>:<n>,...)
    inputBinding:
      position: 10
  - id: max_dist1
    type:
      - 'null'
      - int
    doc: maximum distance to first reference structure
    inputBinding:
      position: 10
      prefix: --maxDist1=
      separate: false
  - id: max_dist2
    type:
      - 'null'
      - int
    doc: maximum distance to second reference structure
    inputBinding:
      position: 10
      prefix: --maxDist2=
      separate: false
  - id: no_bt
    type:
      - 'null'
      - boolean
    doc: do not backtrack structures, calculate energy contributions only
    inputBinding:
      position: 10
      prefix: --noBT
  - id: circ
    type:
      - 'null'
      - boolean
    doc: Assume a circular (instead of linear) RNA molecule.
    inputBinding:
      position: 10
      prefix: --circ
  - id: temp
    type:
      - 'null'
      - float
    doc: Rescale energy parameters to a temperature of temp C. Default is 37C.
    inputBinding:
      position: 10
      prefix: --temp=
      separate: false
  - id: param_file
    type:
      - 'null'
      - File
    doc: Read energy parameters from paramfile, instead of using the default parameter set.
    inputBinding:
      position: 10
      prefix: --paramFile=
      separate: false
  - id: salt
    type:
      - 'null'
      - float
    doc: Set salt concentration in molar (M). Default is 1.021M.
    inputBinding:
      position: 10
      prefix: --salt=
      separate: false
  - id: dangles
    type:
      - 'null'
      - int
    doc: How to treat "dangling end" energies for bases adjacent to helices in free ends and multi-loops
      (possible values="0", "2" default=`2')
    inputBinding:
      position: 10
      prefix: --dangles=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
stdout: RNA2Dfold.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
