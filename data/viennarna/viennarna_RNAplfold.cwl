cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAplfold
label: viennarna_RNAplfold
doc: |-
  Calculate average pair probabilities and mean unpaired probabilities for windows of an RNA. Reads sequences from standard input.

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
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Report only base pairs with an average probability larger than 'cutoff' in the dot plot.
    inputBinding:
      position: 10
      prefix: --cutoff=
      separate: false
  - id: print_onthefly
    type:
      - 'null'
      - boolean
    doc: Save memory by printing out everything during computation.
    inputBinding:
      position: 10
      prefix: --print_onthefly
  - id: opening_energies
    type:
      - 'null'
      - boolean
    doc: Switch output from probabilities to their logarithms.
    inputBinding:
      position: 10
      prefix: --opening_energies
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
  - id: winsize
    type:
      - 'null'
      - int
    doc: Average the pair probabilities over windows of given size.
    inputBinding:
      position: 10
      prefix: --winsize=
      separate: false
  - id: span
    type:
      - 'null'
      - int
    doc: Set the maximum allowed separation of a base pair to span.
    inputBinding:
      position: 10
      prefix: --span=
      separate: false
  - id: ulength
    type:
      - 'null'
      - int
    doc: Compute the mean probability that regions of length 1 to a given length are unpaired.
    inputBinding:
      position: 10
      prefix: --ulength=
      separate: false
  - id: shape
    type:
      - 'null'
      - File
    doc: Use SHAPE reactivity data to guide structure predictions.
    inputBinding:
      position: 10
      prefix: --shape=
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
  - id: modifications
    type:
      - 'null'
      - string
    doc: Allow for modified bases within the RNA sequence string.
    inputBinding:
      position: 10
      prefix: --modifications=
      separate: false
  - id: mod_file
    type:
      - 'null'
      - string
    doc: Use additional modified base data from JSON file.
    inputBinding:
      position: 10
      prefix: --mod-file=
      separate: false
  - id: dangles
    type:
      - 'null'
      - int
    doc: Specify "dangling end" model for bases adjacent to helices in free ends and multi-loops.
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
  - id: ps_files
    type:
      type: array
      items: File
    doc: PostScript plots written by the program (structure plots, dot plots)
    outputBinding:
      glob:
        - '*.ps'
  - id: unpaired_files
    type:
      type: array
      items: File
    doc: Mean unpaired probability tables (name_lunp, or name_openen for opening energies)
    outputBinding:
      glob:
        - '*_lunp'
        - '*_openen'
  - id: pair_probability_files
    type:
      type: array
      items: File
    doc: Base pair probabilities written with --print_onthefly
    outputBinding:
      glob:
        - '*_basepairs'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
