cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAdistance
label: viennarna_RNAdistance
doc: |-
  Calculate distances between RNA secondary structures (tree edit distance, string alignment, base pair distance). Reads structures from standard input.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: structures
    type: File
    doc: RNA secondary structures in dot-bracket notation, one per line.
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: distance
    type:
      - 'null'
      - string
    doc: Specify the distance representation to be used in calculations.
    inputBinding:
      position: 10
      prefix: --distance=
      separate: false
  - id: compare
    type:
      - 'null'
      - string
    doc: Specify the comparison directive.
    inputBinding:
      position: 10
      prefix: --compare=
      separate: false
  - id: shapiro
    type:
      - 'null'
      - boolean
    doc: Use the Bruce Shapiro's cost matrix for comparing coarse structures.
    inputBinding:
      position: 10
      prefix: --shapiro
  - id: backtrack
    type:
      - 'null'
      - boolean
    doc: Print an "alignment" with gaps of the structures, to show matching substructures. The aligned
      structures are written to <filename>, if specified. (flag form without a value)
    inputBinding:
      position: 10
      prefix: --backtrack
  - id: backtrack_file
    type:
      - 'null'
      - string
    doc: Print an "alignment" with gaps of the structures, to show matching substructures. The aligned
      structures are written to <filename>, if specified. (value form)
    inputBinding:
      position: 10
      prefix: --backtrack=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
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
stdin: $(inputs.structures.path)
stdout: RNAdistance.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
