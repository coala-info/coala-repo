cwlVersion: v1.2
class: CommandLineTool
baseCommand: CoFold
label: cofold_CoFold
doc: "CoFold: RNA secondary structure prediction (minimum free energy and partition
  function) with co-transcriptional folding effects, derived from RNAfold 2.0.4.
  Reads sequences from standard input.\n\nTool homepage: https://github.com/jujubix/cofold"
inputs:
  - id: sequences
    type: File
    doc: RNA sequences (one per line, or FASTA), read from standard input
  - id: dist_alpha
    type: double
    doc: A value between 0 and 1 for the alpha CoFold model parameter (authors' 
      optimal value 0.5)
    inputBinding:
      position: 101
      prefix: --distAlpha
  - id: dist_tau
    type: double
    doc: A value greater than 0 for the tau CoFold model parameter (authors' 
      optimal value 640)
    inputBinding:
      position: 101
      prefix: --distTau
  - id: circ
    type:
      - 'null'
      - boolean
    doc: Assume a circular (instead of linear) RNA molecule.
    inputBinding:
      position: 101
      prefix: --circ
  - id: constraint
    type:
      - 'null'
      - boolean
    doc: Calculate structures subject to constraints.
    inputBinding:
      position: 101
      prefix: --constraint
  - id: dangles
    type:
      - 'null'
      - int
    doc: How to treat "dangling end" energies for bases adjacent to helices in free
      ends and multi-loops
    inputBinding:
      position: 101
      prefix: --dangles
  - id: mea
    type:
      - 'null'
      - float
    doc: Calculate an MEA (maximum expected accuracy) structure, where the expected
      accuracy is computed from the pair probabilities
    inputBinding:
      position: 101
      prefix: --MEA=
      separate: false
  - id: no_closing_gu
    type:
      - 'null'
      - boolean
    doc: Do not allow GU pairs at the end of helices
    inputBinding:
      position: 101
      prefix: --noClosingGU
  - id: no_gu
    type:
      - 'null'
      - boolean
    doc: Do not allow GU pairs
    inputBinding:
      position: 101
      prefix: --noGU
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: Produce structures without lonely pairs (helices of length 1).
    inputBinding:
      position: 101
      prefix: --noLP
  - id: no_ps
    type:
      - 'null'
      - boolean
    doc: Do not produce postscript drawing of the mfe structure.
    inputBinding:
      position: 101
      prefix: --noPS
  - id: no_tetra
    type:
      - 'null'
      - boolean
    doc: Do not include special tabulated stabilizing energies for tri-, tetra- and
      hexaloop hairpins.
    inputBinding:
      position: 101
      prefix: --noTetra
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitude nucleotide "T" with "U"
    inputBinding:
      position: 101
      prefix: --noconv
  - id: param_file
    type:
      - 'null'
      - File
    doc: Read energy parameters from paramfile, instead of using the default parameter
      set.
    inputBinding:
      position: 101
      prefix: --paramFile
  - id: partfunc
    type:
      - 'null'
      - int
    doc: Calculate the partition function and base pairing probability matrix.
    inputBinding:
      position: 101
      prefix: --partfunc=
      separate: false
  - id: temp
    type:
      - 'null'
      - float
    doc: Rescale energy parameters to a temperature of temp C.
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Predicted structures and energies
  - id: postscript_plots
    type:
      type: array
      items: File
    doc: Structure and dot plot PostScript files (name_ss.ps, name_dp.ps, rna.ps, 
      dot.ps)
    outputBinding:
      glob: '*.ps'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cofold:2.0.4--h87f3376_5
stdin: $(inputs.sequences.path)
stdout: cofold_CoFold.out
