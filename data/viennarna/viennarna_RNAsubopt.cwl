cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAsubopt
label: viennarna_RNAsubopt
doc: |-
  Calculate suboptimal secondary structures of RNAs.

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
  - id: infile
    type: File
    doc: Read a file instead of reading from stdin.
    inputBinding:
      position: 10
      prefix: --infile=
      separate: false
  - id: outfile
    type:
      - 'null'
      - string
    doc: Print output to file instead of stdout.
    inputBinding:
      position: 10
      prefix: --outfile=
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
  - id: delta_energy
    type:
      - 'null'
      - string
    doc: Compute suboptimal structures with energy in a certain range of the optimum (kcal/mol).
    inputBinding:
      position: 10
      prefix: --deltaEnergy=
      separate: false
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Sort the suboptimal structures by energy and lexicographical order.
    inputBinding:
      position: 10
      prefix: --sorted
  - id: stoch_bt
    type:
      - 'null'
      - int
    doc: Randomly draw structures according to their probability in the Boltzmann ensemble.
    inputBinding:
      position: 10
      prefix: --stochBT=
      separate: false
  - id: non_redundant
    type:
      - 'null'
      - boolean
    doc: Enable non-redundant sampling strategy.
    inputBinding:
      position: 10
      prefix: --nonRedundant
  - id: circ
    type:
      - 'null'
      - boolean
    doc: Assume a circular (instead of linear) RNA molecule.
    inputBinding:
      position: 10
      prefix: --circ
  - id: dos
    type:
      - 'null'
      - boolean
    doc: Compute density of states instead of secondary structures.
    inputBinding:
      position: 10
      prefix: --dos
  - id: zuker
    type:
      - 'null'
      - boolean
    doc: Compute Zuker suboptimals instead of all suboptimal structures within an energy band around the
      MFE.
    inputBinding:
      position: 10
      prefix: --zuker
  - id: gquad
    type:
      - 'null'
      - boolean
    doc: Incoorporate G-Quadruplex formation.
    inputBinding:
      position: 10
      prefix: --gquad
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
    doc: Calculate structures subject to constraints. (flag form without a value)
    inputBinding:
      position: 10
      prefix: --constraint
  - id: constraint_file
    type:
      - 'null'
      - File
    doc: Calculate structures subject to constraints. (value form)
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
  - id: sp_data
    type:
      - 'null'
      - File
    doc: Read structure probing data from an input file and guide the predictions accordingly. Must precede
      the strategy, i.e. a data file must be specified before the corresponding --sp-strategy option!
    inputBinding:
      position: 10
      prefix: --sp-data=
      separate: false
  - id: sp_strategy
    type:
      - 'null'
      - string
    doc: Select the strategy how the probing data is used to guide the structure predictions.
    inputBinding:
      position: 10
      prefix: --sp-strategy=
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
  - id: log_ml
    type:
      - 'null'
      - boolean
    doc: Recompute energies of structures using a logarithmic energy function for multi-loops before output.
    inputBinding:
      position: 10
      prefix: --logML
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: outfile_result
    type:
      - 'null'
      - File
    doc: Output file written with --outfile
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAsubopt.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
