cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNApvmin
label: viennarna_RNApvmin
doc: |-
  Calculate a perturbation vector that minimizes the discrepancy between predicted and observed pairing probabilities (SHAPE data). Reads the sequence from standard input.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: sequence
    type: File
    doc: File with the RNA sequence.
  - id: shape_file
    type: File
    doc: File with SHAPE reactivities.
    inputBinding:
      position: 100
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Set the number of threads used for calculations.
    inputBinding:
      position: 10
      prefix: --numThreads=
      separate: false
  - id: shape_conversion
    type:
      - 'null'
      - string
    doc: Specify the method used to convert SHAPE reactivities to pairing probabilities.
    inputBinding:
      position: 10
      prefix: --shapeConversion=
      separate: false
  - id: tau_sigma_ratio
    type:
      - 'null'
      - float
    doc: Ratio of the weighting factors tau and sigma.
    inputBinding:
      position: 10
      prefix: --tauSigmaRatio=
      separate: false
  - id: objective_function
    type:
      - 'null'
      - int
    doc: The energies of the perturbation vector and the discripancies between predicted and observed
      pairing probabilities contribute to the objective function. This parameter defines, which function
      is used to process the contributions before summing them up. 0 square 1 absolute.
    inputBinding:
      position: 10
      prefix: --objectiveFunction=
      separate: false
  - id: sample_size
    type:
      - 'null'
      - int
    doc: The iterative minimization process requires to evaluate the gradient of the objective function.
    inputBinding:
      position: 10
      prefix: --sampleSize=
      separate: false
  - id: non_redundant
    type:
      - 'null'
      - boolean
    doc: Enable non-redundant sampling strategy.
    inputBinding:
      position: 10
      prefix: --nonRedundant
  - id: intermediate_path
    type:
      - 'null'
      - string
    doc: Write an output file for each iteration of the minimization process.
    inputBinding:
      position: 10
      prefix: --intermediatePath=
      separate: false
  - id: initial_vector
    type:
      - 'null'
      - float
    doc: Specify the vector of initial pertubations.
    inputBinding:
      position: 10
      prefix: --initialVector=
      separate: false
  - id: minimizer
    type:
      - 'null'
      - string
    doc: Set the minimizing algorithm used for finding an appropriate perturbation vector. (possible values="conjugate_fr",
      "conjugate_pr", "vector_bfgs", "vector_bfgs2", "steepest_descent", "default" default=`default')
    inputBinding:
      position: 10
      prefix: --minimizer=
      separate: false
  - id: max_bp_span
    type:
      - 'null'
      - int
    doc: Set the maximum base pair span.
    inputBinding:
      position: 10
      prefix: --maxBPspan=
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdin: $(inputs.sequence.path)
stdout: RNApvmin.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
