cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAheat
label: viennarna_RNAheat
doc: |-
  Calculate the specific heat of an RNA sequence as a function of temperature.

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
  - id: infile
    type:
      - 'null'
      - File
    doc: Read a file instead of reading from stdin
    inputBinding:
      position: 10
      prefix: --infile=
      separate: false
  - id: jobs
    type:
      - 'null'
      - int
    doc: Split batch input into jobs and start processing in parallel using multiple threads. A value
      of 0 indicates to use as many parallel threads as computation cores are available.
    inputBinding:
      position: 10
      prefix: --jobs=
      separate: false
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitute nucleotide "T" with "U".
    inputBinding:
      position: 10
      prefix: --noconv
  - id: auto_id
    type:
      - 'null'
      - boolean
    doc: Automatically generate an ID for each sequence.
    inputBinding:
      position: 10
      prefix: --auto-id
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: Prefix for automatically generated IDs (as used in output file names)
    inputBinding:
      position: 10
      prefix: --id-prefix=
      separate: false
  - id: tmin
    type:
      - 'null'
      - float
    doc: Lowest temperature.
    inputBinding:
      position: 10
      prefix: --Tmin=
      separate: false
  - id: tmax
    type:
      - 'null'
      - float
    doc: Highest temperature.
    inputBinding:
      position: 10
      prefix: --Tmax=
      separate: false
  - id: stepsize
    type:
      - 'null'
      - float
    doc: Calculate partition function every stepsize degrees C.
    inputBinding:
      position: 10
      prefix: --stepsize=
      separate: false
  - id: ipoints
    type:
      - 'null'
      - int
    doc: The program fits a parabola to 2*ipoints+1 data points to calculate 2nd derivatives. Increasing
      this parameter produces a smoother curve.
    inputBinding:
      position: 10
      prefix: --ipoints=
      separate: false
  - id: circ
    type:
      - 'null'
      - boolean
    doc: Assume a circular (instead of linear) RNA molecule.
    inputBinding:
      position: 10
      prefix: --circ
  - id: gquad
    type:
      - 'null'
      - boolean
    doc: Incoorporate G-Quadruplex formation into the structure prediction algorithm.
    inputBinding:
      position: 10
      prefix: --gquad
  - id: max_bp_span
    type:
      - 'null'
      - int
    doc: Set the maximum base pair span.
    inputBinding:
      position: 10
      prefix: --maxBPspan=
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
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: Produce structures without lonely pairs (helices of length 1).
    inputBinding:
      position: 10
      prefix: --noLP
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence file(s)
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAheat.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
