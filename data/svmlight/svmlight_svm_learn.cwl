cwlVersion: v1.2
class: CommandLineTool
baseCommand: svm_learn
label: svmlight_svm_learn
doc: "SVM-light V6.02: Support Vector Machine, learning module\n\nTool homepage:
  http://svmlight.joachims.org/"
inputs:
  - id: example_file
    type: File
    doc: File with training data
    inputBinding:
      position: 101
  - id: model_file
    type: string
    doc: File to store the learned decision rule in
    inputBinding:
      position: 102
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'Verbosity level, 0 to 3 (default 1)'
    inputBinding:
      position: 1
      prefix: -v
  - id: learning_type
    type:
      - 'null'
      - string
    doc: 'Select between classification (c), regression (r), and preference ranking
      (p) (default classification)'
    inputBinding:
      position: 1
      prefix: -z
  - id: c_parameter
    type:
      - 'null'
      - double
    doc: 'C: trade-off between training error and margin (default [avg. x*x]^-1)'
    inputBinding:
      position: 1
      prefix: -c
  - id: epsilon_width
    type:
      - 'null'
      - double
    doc: 'Epsilon width of tube for regression (default 0.1)'
    inputBinding:
      position: 1
      prefix: -w
  - id: cost_factor
    type:
      - 'null'
      - double
    doc: 'Cost-factor, by which training errors on positive examples outweight errors
      on negative examples (default 1)'
    inputBinding:
      position: 1
      prefix: -j
  - id: biased_hyperplane
    type:
      - 'null'
      - int
    doc: 'Use biased hyperplane (x*w+b>0) instead of unbiased hyperplane (x*w>0)
      (0 or 1, default 1)'
    inputBinding:
      position: 1
      prefix: -b
  - id: remove_inconsistent
    type:
      - 'null'
      - int
    doc: 'Remove inconsistent training examples and retrain (0 or 1, default 0)'
    inputBinding:
      position: 1
      prefix: -i
  - id: leave_one_out
    type:
      - 'null'
      - int
    doc: 'Compute leave-one-out estimates (0 or 1, default 0)'
    inputBinding:
      position: 1
      prefix: -x
  - id: rho
    type:
      - 'null'
      - double
    doc: 'Value of rho for XiAlpha-estimator and for pruning leave-one-out computation
      (0 to 2, default 1.0)'
    inputBinding:
      position: 1
      prefix: -o
  - id: search_depth
    type:
      - 'null'
      - int
    doc: 'Search depth for extended XiAlpha-estimator (0 to 100, default 0)'
    inputBinding:
      position: 1
      prefix: -k
  - id: positive_fraction
    type:
      - 'null'
      - double
    doc: 'Fraction of unlabeled examples to be classified into the positive class
      (0 to 1, default is the ratio of positive and negative examples in the training
      data)'
    inputBinding:
      position: 1
      prefix: -p
  - id: kernel_type
    type:
      - 'null'
      - int
    doc: 'Type of kernel function: 0 linear (default), 1 polynomial (s a*b+c)^d,
      2 radial basis function exp(-gamma ||a-b||^2), 3 sigmoid tanh(s a*b + c),
      4 user defined kernel from kernel.h'
    inputBinding:
      position: 1
      prefix: -t
  - id: poly_degree
    type:
      - 'null'
      - int
    doc: Parameter d in polynomial kernel
    inputBinding:
      position: 1
      prefix: -d
  - id: rbf_gamma
    type:
      - 'null'
      - double
    doc: Parameter gamma in rbf kernel
    inputBinding:
      position: 1
      prefix: -g
  - id: kernel_s
    type:
      - 'null'
      - double
    doc: Parameter s in sigmoid/poly kernel
    inputBinding:
      position: 1
      prefix: -s
  - id: kernel_c
    type:
      - 'null'
      - double
    doc: Parameter c in sigmoid/poly kernel
    inputBinding:
      position: 1
      prefix: -r
  - id: user_kernel_parameter
    type:
      - 'null'
      - string
    doc: Parameter of user defined kernel
    inputBinding:
      position: 1
      prefix: -u
  - id: max_qp_size
    type:
      - 'null'
      - int
    doc: 'Maximum size of QP-subproblems (2 or more, default 10)'
    inputBinding:
      position: 1
      prefix: -q
  - id: new_variables
    type:
      - 'null'
      - int
    doc: 'Number of new variables entering the working set in each iteration (2 to
      q, default n = q)'
    inputBinding:
      position: 1
      prefix: -n
  - id: cache_size
    type:
      - 'null'
      - int
    doc: 'Size of cache for kernel evaluations in MB (5 or more, default 40)'
    inputBinding:
      position: 1
      prefix: -m
  - id: termination_eps
    type:
      - 'null'
      - double
    doc: 'Allowed error for the termination criterion y[w*x+b]-1 >= eps (default
      0.001)'
    inputBinding:
      position: 1
      prefix: -e
  - id: shrinking_iterations
    type:
      - 'null'
      - int
    doc: 'Number of iterations a variable needs to be optimal before considered for
      shrinking (5 or more, default 100)'
    inputBinding:
      position: 1
      prefix: -h
  - id: final_optimality_check
    type:
      - 'null'
      - int
    doc: 'Do final optimality check for variables removed by shrinking (0 or 1,
      default 1)'
    inputBinding:
      position: 1
      prefix: -f
  - id: restart_alpha_file
    type:
      - 'null'
      - File
    doc: Read alphas from this file and use them as starting point (default disabled)
    inputBinding:
      position: 1
      prefix: -y
  - id: max_no_progress_iterations
    type:
      - 'null'
      - int
    doc: 'Terminate optimization if no progress after this number of iterations
      (default 100000)'
    inputBinding:
      position: 1
      prefix: '-#'
  - id: predicted_labels_file
    type:
      - 'null'
      - string
    doc: File to write predicted labels of unlabeled examples into after transductive
      learning
    inputBinding:
      position: 1
      prefix: -l
  - id: alphas_file
    type:
      - 'null'
      - string
    doc: Write all alphas to this file after learning (in the same order as in the
      training set)
    inputBinding:
      position: 1
      prefix: -a
outputs:
  - id: out_model_file
    type: File
    doc: Learned model
    outputBinding:
      glob: $(inputs.model_file)
  - id: out_predicted_labels_file
    type:
      - 'null'
      - File
    doc: Predicted labels of unlabeled examples after transductive learning
    outputBinding:
      glob: $(inputs.predicted_labels_file)
  - id: out_alphas_file
    type:
      - 'null'
      - File
    doc: Alphas written after learning
    outputBinding:
      glob: $(inputs.alphas_file)
  - id: stdout
    type: stdout
    doc: Training log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svmlight:6.02--h7b50bb2_8
stdout: svmlight_svm_learn.out
