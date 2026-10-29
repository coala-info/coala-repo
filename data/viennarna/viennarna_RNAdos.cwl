cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAdos
label: viennarna_RNAdos
doc: |-
  Calculate the density of states for each energy band of an RNA.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: sequence
    type: string
    doc: The RNA sequence (ACGU).
    inputBinding:
      position: 10
      prefix: --sequence=
      separate: false
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Set the number of threads used for calculations (only available when compiled with OpenMP support)
    inputBinding:
      position: 10
      prefix: --numThreads=
      separate: false
  - id: max_energy
    type:
      - 'null'
      - int
    doc: Structures are only counted until this threshold is reached. Default is 0 kcal/mol.
    inputBinding:
      position: 10
      prefix: --max-energy=
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAdos.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
