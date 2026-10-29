cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAinverse
label: viennarna_RNAinverse
doc: |-
  Find RNA sequences with a given secondary structure (inverse folding). Reads structure and start sequence from standard input.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: input
    type: File
    doc: 'Alternating lines: target structure in dot-bracket notation, then start sequence.'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: In conjunction with a negative value supplied to -R, print the last subsequence and substructure
      for each unsuccessful search.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: function
    type:
      - 'null'
      - string
    doc: Use minimum energy (-Fm), partition function folding (-Fp) or both (-Fmp).
    inputBinding:
      position: 10
      prefix: --function=
      separate: false
  - id: final
    type:
      - 'null'
      - float
    doc: In combination with -Fp stop search when sequence is found with E(s)-F is smaller than final,
      where F=-kT*ln(Q).
    inputBinding:
      position: 10
      prefix: --final=
      separate: false
  - id: repeat
    type:
      - 'null'
      - int
    doc: 'Search repeatedly for the same structure. If an argument is supplied to this option it must
      follow the option flag immediately. E.g.: -R5'
    inputBinding:
      position: 10
      prefix: --repeat=
      separate: false
  - id: alphabet
    type:
      - 'null'
      - string
    doc: Find sequences using only nucleotides from a given alphabet.
    inputBinding:
      position: 10
      prefix: --alphabet=
      separate: false
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
stdout: RNAinverse.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
