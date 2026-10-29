cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNApaln
label: viennarna_RNApaln
doc: |-
  Calculate distances between thermodynamic equilibrium structures (base pair probabilities) of RNA sequences via profile alignment.

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
  - id: print_alignment
    type:
      - 'null'
      - boolean
    doc: Print an "alignment" with gaps of the profiles The aligned structures are written to filename,
      if specified Otherwise output is written to stdout, unless the -Xm option is set in which case "backtrack.file"
      is used. (flag form without a value)
    inputBinding:
      position: 10
      prefix: --printAlignment
  - id: print_alignment_file
    type:
      - 'null'
      - string
    doc: Print an "alignment" with gaps of the profiles The aligned structures are written to filename,
      if specified Otherwise output is written to stdout, unless the -Xm option is set in which case "backtrack.file"
      is used. (value form)
    inputBinding:
      position: 10
      prefix: --printAlignment=
      separate: false
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitute nucleotide "T" with "U".
    inputBinding:
      position: 10
      prefix: --noconv
  - id: mode
    type:
      - 'null'
      - string
    doc: Set the alignment mode to be used.
    inputBinding:
      position: 10
      prefix: --mode=
      separate: false
  - id: gapo
    type:
      - 'null'
      - float
    doc: Set the gap open penalty
    inputBinding:
      position: 10
      prefix: --gapo=
      separate: false
  - id: gape
    type:
      - 'null'
      - float
    doc: Set the gap extension penalty
    inputBinding:
      position: 10
      prefix: --gape=
      separate: false
  - id: seqw
    type:
      - 'null'
      - float
    doc: Set the weight of sequence (compared to structure) in the scoring function.
    inputBinding:
      position: 10
      prefix: --seqw=
      separate: false
  - id: endgaps
    type:
      - 'null'
      - boolean
    doc: Use free end-gaps
    inputBinding:
      position: 10
      prefix: --endgaps
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
  - id: alignment_result
    type:
      - 'null'
      - File
    doc: Alignment written with --printAlignment=<filename>
    outputBinding:
      glob: $(inputs.print_alignment_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
stdout: RNApaln.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
