cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAeval
label: viennarna_RNAeval
doc: |-
  Evaluate free energy of RNA sequences with given secondary structure.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose and print out energy contribution of each loop in the structure.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: infile
    type:
      - 'null'
      - File
    doc: Read a file instead of reading from stdin.
    inputBinding:
      position: 10
      prefix: --infile=
      separate: false
  - id: msa
    type:
      - 'null'
      - boolean
    doc: Input is multiple sequence alignment in Stockholm 1.0 format.
    inputBinding:
      position: 10
      prefix: --msa
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
  - id: shape
    type:
      - 'null'
      - File
    doc: Use SHAPE reactivity data to guide structure predictions.
    inputBinding:
      position: 10
      prefix: --shape=
      separate: false
  - id: shape_conversion
    type:
      - 'null'
      - string
    doc: Select method for SHAPE reactivity conversion.
    inputBinding:
      position: 10
      prefix: --shapeConversion=
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
  - id: log_ml
    type:
      - 'null'
      - boolean
    doc: Recalculate energies of structures using a logarithmic energy function for multi-loops before
      output.
    inputBinding:
      position: 10
      prefix: --logML
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
  - id: old
    type:
      - 'null'
      - boolean
    doc: use old energy evaluation, treating gaps as characters.
    inputBinding:
      position: 10
      prefix: --old
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) with sequence and structure (for example RNAfold output)
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAeval.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
