cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAPKplex
label: viennarna_RNAPKplex
doc: |-
  Predict RNA secondary structures including pseudoknots. Reads sequences from standard input.

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
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Only consider unpaired probabities > cutoff for putative PK sites.
    inputBinding:
      position: 10
      prefix: --cutoff=
      separate: false
  - id: energy_cutoff
    type:
      - 'null'
      - float
    doc: Energy cutoff or pseudoknot initiation cost. Minimum energy gain of a pseudoknot interaction
      for it to be returned. Pseudoknots with smaller energy gains are rejected.
    inputBinding:
      position: 10
      prefix: --energyCutoff=
      separate: false
  - id: subopts
    type:
      - 'null'
      - float
    doc: print suboptimal structures whose energy difference of the pseudoknot to the optimum pseudoknot
      is smaller than the given value.
    inputBinding:
      position: 10
      prefix: --subopts=
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.input.path)
stdout: RNAPKplex.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
