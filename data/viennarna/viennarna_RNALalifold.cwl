cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNALalifold
label: viennarna_RNALalifold
doc: |-
  Calculate locally stable secondary structures for a set of aligned RNAs.

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
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Create comma separated output (csv)
    inputBinding:
      position: 10
      prefix: --csv
  - id: aln
    type:
      - 'null'
      - string
    doc: Produce output alignments and secondary structure plots for each hit found.
    inputBinding:
      position: 10
      prefix: --aln=
      separate: false
  - id: aln_stk
    type:
      - 'null'
      - string
    doc: Add hits to a multi-Stockholm formatted output file.
    inputBinding:
      position: 10
      prefix: --aln-stk=
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
  - id: split_contributions
    type:
      - 'null'
      - boolean
    doc: Split the free energy contributions into separate parts
    inputBinding:
      position: 10
      prefix: --split-contributions
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
  - id: max_bp_span
    type:
      - 'null'
      - int
    doc: Set the maximum allowed separation of a base pair to span. I.e. no pairs (i,j) with j-i>span
      will be allowed.
    inputBinding:
      position: 10
      prefix: --maxBPspan=
      separate: false
  - id: threshold
    type:
      - 'null'
      - float
    doc: Energy threshold in kcal/mol per nucleotide above which secondary structure hits are omitted
      in the output.
    inputBinding:
      position: 10
      prefix: --threshold=
      separate: false
  - id: gquad
    type:
      - 'null'
      - boolean
    doc: Incoorporate G-Quadruplex formation into the structure prediction algorithm.
    inputBinding:
      position: 10
      prefix: --gquad
  - id: shape
    type:
      - 'null'
      - string
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
  - id: aln_eps
    type:
      - 'null'
      - string
    doc: Produce colored and structure annotated subalignment for each hit.
    inputBinding:
      position: 10
      prefix: --aln-EPS=
      separate: false
  - id: aln_eps_ss
    type:
      - 'null'
      - string
    doc: Produce colored consensus secondary structure plots in PostScript format.
    inputBinding:
      position: 10
      prefix: --aln-EPS-ss=
      separate: false
  - id: alignment
    type: File
    doc: Input multiple sequence alignment file.
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
  - id: alignment_files
    type:
      type: array
      items: File
    doc: Hit alignments and plots written with --aln, --aln-EPS or --aln-EPS-ss
    outputBinding:
      glob:
        - '*.aln'
        - '*.eps'
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
stdout: RNALalifold.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
