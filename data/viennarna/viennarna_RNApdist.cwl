cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNApdist
label: viennarna_RNApdist
doc: |-
  Calculate distances between thermodynamic equilibrium structures (base pair probabilities) of RNA sequences.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: input
    type: File
    doc: RNA sequences (FASTA or plain text).
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitute nucleotide "T" with "U".
    inputBinding:
      position: 10
      prefix: --noconv
  - id: compare
    type:
      - 'null'
      - string
    doc: Specify the comparison directive.
    inputBinding:
      position: 10
      prefix: --compare=
      separate: false
  - id: backtrack
    type:
      - 'null'
      - boolean
    doc: Print an "alignment" with gaps of the profiles. The aligned structures are written to <filename>,
      if specified. (flag form without a value)
    inputBinding:
      position: 10
      prefix: --backtrack
  - id: backtrack_file
    type:
      - 'null'
      - string
    doc: Print an "alignment" with gaps of the profiles. The aligned structures are written to <filename>,
      if specified. (value form)
    inputBinding:
      position: 10
      prefix: --backtrack=
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
    doc: set energy model for treatment of dangling bases. (possible values="0", "2" default=`2')
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
  - id: ps_files
    type:
      type: array
      items: File
    doc: PostScript plots written by the program (structure plots, dot plots)
    outputBinding:
      glob:
        - '*.ps'
  - id: backtrack_alignment
    type:
      - 'null'
      - File
    doc: Alignment written with --backtrack=<filename>
    outputBinding:
      glob: $(inputs.backtrack_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
stdout: RNApdist.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
