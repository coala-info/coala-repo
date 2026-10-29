cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAup
label: viennarna_RNAup
doc: |-
  Calculate the thermodynamics of RNA-RNA interactions (accessibility-aware). Reads sequences from standard input.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: input
    type: File
    doc: 'RNA sequences: either two sequences joined by & on one line, or FASTA records.'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: no_output_file
    type:
      - 'null'
      - boolean
    doc: Do not produce an output file.
    inputBinding:
      position: 10
      prefix: --no_output_file
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not produce a header with the command line parameters used in the outputfile.
    inputBinding:
      position: 10
      prefix: --no_header
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitute nucleotide "T" with "U".
    inputBinding:
      position: 10
      prefix: --noconv
  - id: ulength
    type:
      - 'null'
      - int
    doc: Specify the length of the unstructured region in the output.
    inputBinding:
      position: 10
      prefix: --ulength=
      separate: false
  - id: contributions
    type:
      - 'null'
      - string
    doc: Specify the contributions listed in the output.
    inputBinding:
      position: 10
      prefix: --contributions=
      separate: false
  - id: window
    type:
      - 'null'
      - int
    doc: Set the maximal length of the region of interaction.
    inputBinding:
      position: 10
      prefix: --window=
      separate: false
  - id: include_both
    type:
      - 'null'
      - boolean
    doc: Include the probability of unpaired regions in both (b) RNAs.
    inputBinding:
      position: 10
      prefix: --include_both
  - id: extend5
    type:
      - 'null'
      - int
    doc: Extend the region of interaction in the target to some residues on the 5' side.
    inputBinding:
      position: 10
      prefix: --extend5=
      separate: false
  - id: extend3
    type:
      - 'null'
      - int
    doc: Extend the region of interaction in the target to some residues on the 3' side.
    inputBinding:
      position: 10
      prefix: --extend3=
      separate: false
  - id: interaction_pairwise
    type:
      - 'null'
      - boolean
    doc: Activate pairwise interaction mode.
    inputBinding:
      position: 10
      prefix: --interaction_pairwise
  - id: interaction_first
    type:
      - 'null'
      - boolean
    doc: Activate interaction mode using first sequence only.
    inputBinding:
      position: 10
      prefix: --interaction_first
  - id: constraint
    type:
      - 'null'
      - boolean
    doc: Apply structural constraint(s) during prediction.
    inputBinding:
      position: 10
      prefix: --constraint
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
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: result_files
    type:
      type: array
      items: File
    doc: Output files written by RNAup (name_w<window>_u<ulength>.out)
    outputBinding:
      glob:
        - '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
stdout: RNAup.stdout.txt
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
