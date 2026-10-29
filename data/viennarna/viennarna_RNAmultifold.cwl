cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAmultifold
label: viennarna_RNAmultifold
doc: |-
  Calculate secondary structures of multiple interacting RNAs (multi-strand complexes).

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
    doc: Prefix for automatically generated IDs (as used in output file names).
    inputBinding:
      position: 10
      prefix: --id-prefix=
      separate: false
  - id: partfunc
    type:
      - 'null'
      - int
    doc: Calculate the partition function and base pairing probability matrix in addition to the MFE structure.
      Default is calculation of mfe structure only.
    inputBinding:
      position: 10
      prefix: --partfunc=
      separate: false
  - id: all_pf
    type:
      - 'null'
      - int
    doc: Compute the partition function and free energies not only for the complex formed by the input
      sequences (the "ABC... mutimer"), but also of all complexes formed by the input sequences up to
      the number of input sequences, e.g. AAA, AAB, ABB, BBB, etc.
    inputBinding:
      position: 10
      prefix: --all_pf=
      separate: false
  - id: concentrations
    type:
      - 'null'
      - boolean
    doc: In addition to everything listed under the -a option, read in initial monomer concentrations
      and compute the expected equilibrium concentrations of all possible species (A, B, AA, BB, AB, etc).
    inputBinding:
      position: 10
      prefix: --concentrations
  - id: concfile
    type:
      - 'null'
      - File
    doc: Specify a file with initial concentrations for the input sequences.
    inputBinding:
      position: 10
      prefix: --concfile=
      separate: false
  - id: absolute_concentrations
    type:
      - 'null'
      - boolean
    doc: Report absolute instead of relative concentrations
    inputBinding:
      position: 10
      prefix: --absolute-concentrations
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
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence file(s); strands joined by &
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: ps_files
    type:
      type: array
      items: File
    doc: PostScript plots written by the program (structure plots, dot plots)
    outputBinding:
      glob:
        - '*.ps'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAmultifold.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
