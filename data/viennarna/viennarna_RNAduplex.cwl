cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAduplex
label: viennarna_RNAduplex
doc: |-
  Compute the structure upon hybridization of two RNA strands. Reads pairs of sequences from standard input.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: input
    type: File
    doc: Pairs of RNA sequences (FASTA or plain, two sequences per duplex).
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Sort the printed output by free energy.
    inputBinding:
      position: 10
      prefix: --sorted
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitute nucleotide "T" with "U".
    inputBinding:
      position: 10
      prefix: --noconv
  - id: delta_energy
    type:
      - 'null'
      - string
    doc: Compute suboptimal structures with energy in a certain range of the optimum (kcal/mol). Default
      is calculation of mfe structure only.
    inputBinding:
      position: 10
      prefix: --deltaEnergy=
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
    doc: How to treat "dangling end" energies for bases adjacent to helices in free ends and multi-loops.
    inputBinding:
      position: 10
      prefix: --dangles=
      separate: false
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: Produce structures without lonely pairs (helices of length 1).
    inputBinding:
      position: 10
      prefix: --noLP
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
stdout: RNAduplex.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
