cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAcofold
label: viennarna_RNAcofold
doc: calculate secondary structures of two RNAs with dimerization
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence file(s)
    inputBinding:
      position: 1
  - id: detailed_help
    type:
      - 'null'
      - boolean
    doc: Print help, including all details and hidden options, and exit
    inputBinding:
      position: 102
      prefix: --detailed-help
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: Print help, including hidden options, and exit
    inputBinding:
      position: 102
      prefix: --full-help
  - id: jobs
    type:
      - 'null'
      - int
    doc: Split batch input into jobs and start processing in parallel using 
      multiple threads. A value of 0 indicates to use as many parallel threads 
      as computation cores are available.
    inputBinding:
      position: 102
      prefix: --jobs=
      separate: false
  - id: noconv
    type:
      - 'null'
      - boolean
    doc: Do not automatically substitute nucleotide "T" with "U".
    inputBinding:
      position: 102
      prefix: --noconv
  - id: auto_id
    type:
      - 'null'
      - boolean
    doc: Automatically generate an ID for each sequence.
    inputBinding:
      position: 102
      prefix: --auto-id
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: Prefix for automatically generated IDs (as used in output file names).
    inputBinding:
      position: 102
      prefix: --id-prefix
  - id: partfunc
    type:
      - 'null'
      - int
    doc: Calculate the partition function and base pairing probability matrix in
      addition to the mfe structure. Default is calculation of mfe structure 
      only.
    inputBinding:
      position: 102
      prefix: --partfunc=
      separate: false
  - id: all_pf
    type:
      - 'null'
      - int
    doc: Compute the partition function and free energies not only of the 
      hetero-dimer consisting of the two input sequences (the 'AB dimer'), but 
      also of the homo-dimers AA and BB as well as A and B monomers.
    inputBinding:
      position: 102
      prefix: --all_pf=
      separate: false
  - id: concentrations
    type:
      - 'null'
      - boolean
    doc: In addition to everything listed under the -a option, read in initial 
      monomer concentrations and compute the expected equilibrium concentrations
      of the 5 possible species (AB, AA, BB, A, B).
    inputBinding:
      position: 102
      prefix: --concentrations
  - id: concfile
    type:
      - 'null'
      - File
    doc: Specify a file with initial concentrations for the two sequences.
    inputBinding:
      position: 102
      prefix: --concfile
  - id: centroid
    type:
      - 'null'
      - boolean
    doc: Compute the centroid structure.
    inputBinding:
      position: 102
      prefix: --centroid
  - id: mea
    type:
      - 'null'
      - float
    doc: Compute MEA (maximum expected accuracy) structure.
    inputBinding:
      position: 102
      prefix: --MEA=
      separate: false
  - id: gquad
    type:
      - 'null'
      - boolean
    doc: Incoorporate G-Quadruplex formation into the structure prediction 
      algorithm.
    inputBinding:
      position: 102
      prefix: --gquad
  - id: max_bp_span
    type:
      - 'null'
      - int
    doc: Set the maximum base pair span.
    inputBinding:
      position: 102
      prefix: --maxBPspan
  - id: constraint
    type:
      - 'null'
      - File
    doc: Calculate structures subject to constraints.
    inputBinding:
      position: 102
      prefix: --constraint=
      separate: false
  - id: enforce_constraint
    type:
      - 'null'
      - boolean
    doc: Enforce base pairs given by round brackets '(' ')' in structure 
      constraint.
    inputBinding:
      position: 102
      prefix: --enforceConstraint
  - id: shape
    type:
      - 'null'
      - File
    doc: Use SHAPE reactivity data to guide structure predictions.
    inputBinding:
      position: 102
      prefix: --shape
  - id: shape_conversion
    type:
      - 'null'
      - string
    doc: Select method for SHAPE reactivity conversion.
    inputBinding:
      position: 102
      prefix: --shapeConversion
  - id: temp
    type:
      - 'null'
      - float
    doc: Rescale energy parameters to a temperature of temp C. Default is 37C.
    inputBinding:
      position: 102
      prefix: --temp
  - id: param_file
    type:
      - 'null'
      - File
    doc: Read energy parameters from paramfile, instead of using the default 
      parameter set.
    inputBinding:
      position: 102
      prefix: --paramFile
  - id: salt
    type:
      - 'null'
      - float
    doc: Set salt concentration in molar (M). Default is 1.021M.
    inputBinding:
      position: 102
      prefix: --salt
  - id: modifications
    type:
      - 'null'
      - string
    doc: Allow for modified bases within the RNA sequence string.
    inputBinding:
      position: 102
      prefix: --modifications=
      separate: false
  - id: mod_file
    type:
      - 'null'
      - File
    doc: Use additional modified base data from JSON file.
    inputBinding:
      position: 102
      prefix: --mod-file
  - id: dangles
    type:
      - 'null'
      - int
    doc: How to treat "dangling end" energies for bases adjacent to helices in 
      free ends and multi-loops.
    inputBinding:
      position: 102
      prefix: --dangles
  - id: no_lp
    type:
      - 'null'
      - boolean
    doc: Produce structures without lonely pairs (helices of length 1).
    inputBinding:
      position: 102
      prefix: --noLP
  - id: no_ps
    type:
      - 'null'
      - boolean
    doc: Do not produce postscript drawing of the mfe structure.
    inputBinding:
      position: 102
      prefix: --noPS
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAcofold.out
s:url: http://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
