cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAalifold
label: viennarna_RNAalifold
doc: |-
  Calculate secondary structures for a set of aligned RNA sequences (consensus structure).

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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Be quiet.
    inputBinding:
      position: 10
      prefix: --quiet
  - id: input_format
    type:
      - 'null'
      - string
    doc: File format of the input multiple sequence alignment (MSA).
    inputBinding:
      position: 10
      prefix: --input-format=
      separate: false
  - id: mis
    type:
      - 'null'
      - boolean
    doc: 'Output "most informative sequence" instead of simple consensus: For each column of the alignment
      output the set of nucleotides with frequency greater than average in IUPAC notation.'
    inputBinding:
      position: 10
      prefix: --mis
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
  - id: continuous_ids
    type:
      - 'null'
      - boolean
    doc: Use continuous alignment ID numbering when no alignment ID can be retrieved from input data.
    inputBinding:
      position: 10
      prefix: --continuous-ids
  - id: auto_id
    type:
      - 'null'
      - boolean
    doc: Automatically generate an ID for each alignment.
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
    doc: Calculate the partition function and base pairing probability matrix in addition to the mfe structure.
      Default is calculation of mfe structure only.
    inputBinding:
      position: 10
      prefix: --partfunc=
      separate: false
  - id: mea
    type:
      - 'null'
      - float
    doc: Compute MEA (maximum expected accuracy) structure.
    inputBinding:
      position: 10
      prefix: --MEA=
      separate: false
  - id: sci
    type:
      - 'null'
      - boolean
    doc: Compute the structure conservation index (SCI) for the MFE consensus structure of the alignment.
    inputBinding:
      position: 10
      prefix: --sci
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
  - id: stoch_bt
    type:
      - 'null'
      - int
    doc: Stochastic backtrack. Compute a certain number of random structures with a probability dependend
      on the partition function. See -p option in RNAsubopt.
    inputBinding:
      position: 10
      prefix: --stochBT=
      separate: false
  - id: stoch_bt_en
    type:
      - 'null'
      - int
    doc: same as -s option but also print out the energies and probabilities of the backtraced structures.
    inputBinding:
      position: 10
      prefix: --stochBT_en=
      separate: false
  - id: non_redundant
    type:
      - 'null'
      - boolean
    doc: Enable non-redundant sampling strategy.
    inputBinding:
      position: 10
      prefix: --nonRedundant
  - id: max_bp_span
    type:
      - 'null'
      - int
    doc: Set the maximum base pair span.
    inputBinding:
      position: 10
      prefix: --maxBPspan=
      separate: false
  - id: constraint
    type:
      - 'null'
      - boolean
    doc: Calculate structures subject to constraints. The constraining structure will be read from 'stdin',
      the alignment has to be given as a file name on the command line. (flag form without a value)
    inputBinding:
      position: 10
      prefix: --constraint
  - id: constraint_file
    type:
      - 'null'
      - File
    doc: Calculate structures subject to constraints. The constraining structure will be read from 'stdin',
      the alignment has to be given as a file name on the command line. (value form)
    inputBinding:
      position: 10
      prefix: --constraint=
      separate: false
  - id: enforce_constraint
    type:
      - 'null'
      - boolean
    doc: Enforce base pairs given by round brackets '(' ')' in structure constraint.
    inputBinding:
      position: 10
      prefix: --enforceConstraint
  - id: ss_cons
    type:
      - 'null'
      - boolean
    doc: Use consensus structures from Stockholm file ('#=GF SS_cons') as constraint.
    inputBinding:
      position: 10
      prefix: --SS_cons
  - id: shape
    type:
      - 'null'
      - type: array
        items: File
    doc: Use SHAPE reactivity data to guide structure predictions.
    inputBinding:
      position: 10
      prefix: --shape=
      separate: false
      itemSeparator: ','
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
  - id: cfactor
    type:
      - 'null'
      - float
    doc: Set the weight of the covariance term in the energy function
    inputBinding:
      position: 10
      prefix: --cfactor=
      separate: false
  - id: nfactor
    type:
      - 'null'
      - float
    doc: Set the penalty for non-compatible sequences in the covariance term of the energy function
    inputBinding:
      position: 10
      prefix: --nfactor=
      separate: false
  - id: endgaps
    type:
      - 'null'
      - boolean
    doc: Score pairs with endgaps same as gap-gap pairs.
    inputBinding:
      position: 10
      prefix: --endgaps
  - id: ribosum_file
    type:
      - 'null'
      - File
    doc: use specified Ribosum Matrix instead of normal energy model.
    inputBinding:
      position: 10
      prefix: --ribosum_file=
      separate: false
  - id: ribosum_scoring
    type:
      - 'null'
      - boolean
    doc: use ribosum scoring matrix.
    inputBinding:
      position: 10
      prefix: --ribosum_scoring
  - id: old
    type:
      - 'null'
      - boolean
    doc: use old energy evaluation, treating gaps as characters.
    inputBinding:
      position: 10
      prefix: --old
  - id: color
    type:
      - 'null'
      - boolean
    doc: Produce a colored version of the consensus structure plot "alirna.ps" (default b&w only)
    inputBinding:
      position: 10
      prefix: --color
  - id: aln
    type:
      - 'null'
      - boolean
    doc: Produce a colored and structure annotated alignment in PostScript format in the file "aln.ps"
      in the current directory.
    inputBinding:
      position: 10
      prefix: --aln
  - id: aln_stk
    type:
      - 'null'
      - string
    doc: Create a multi-Stockholm formatted output file.
    inputBinding:
      position: 10
      prefix: --aln-stk=
      separate: false
  - id: no_ps
    type:
      - 'null'
      - boolean
    doc: Do not produce postscript drawing of the mfe structure.
    inputBinding:
      position: 10
      prefix: --noPS
  - id: no_dp
    type:
      - 'null'
      - boolean
    doc: Do not produce dot-plot postscript file containing base pair or stack probabilitities.
    inputBinding:
      position: 10
      prefix: --noDP
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multiple sequence alignment file(s)
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
  - id: stockholm_files
    type:
      type: array
      items: File
    doc: Multi-Stockholm output written with --aln-stk
    outputBinding:
      glob:
        - '*.stk'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAalifold.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
