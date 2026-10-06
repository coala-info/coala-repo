cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapc
label: bellmans-gapc
doc: "The Bellman's GAP compiler (gapc) for Algebraic Dynamic Programming. It compiles
  a GAP-L source file into C++ code (NAME.cc, NAME.hh) and a makefile (NAME.mf).\n\n\
  Tool homepage: https://bibiserv.cebitec.uni-bielefeld.de/gapc"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type: File
    doc: The .gap source file to compile
    inputBinding:
      position: 1
  - id: inline
    type:
      - 'null'
      - boolean
    doc: try to inline NTs
    inputBinding:
      position: 102
      prefix: --inline
  - id: instance
    type:
      - 'null'
      - string
    doc: use instance (else first)
    inputBinding:
      position: 102
      prefix: --instance
  - id: product
    type:
      - 'null'
      - string
    doc: use product of algebras
    inputBinding:
      position: 102
      prefix: --product
  - id: output_name
    type:
      - 'null'
      - string
    default: out.cc
    doc: output filename (out.cc)
    inputBinding:
      position: 102
      prefix: --output
  - id: class_name
    type:
      - 'null'
      - string
    doc: 'default: basename(output)'
    inputBinding:
      position: 102
      prefix: --class-name
  - id: tab
    type:
      - 'null'
      - string
    doc: overwrite table conf with this list
    inputBinding:
      position: 102
      prefix: --tab
  - id: table_design
    type:
      - 'null'
      - boolean
    doc: automatically compute optimal table configuration (ignore conf from source
      file)
    inputBinding:
      position: 102
      prefix: --table-design
  - id: tab_all
    type:
      - 'null'
      - boolean
    doc: tabulate everything
    inputBinding:
      position: 102
      prefix: --tab-all
  - id: cyk
    type:
      - 'null'
      - boolean
    doc: 'bottom up evalulation codgen (default: top down unger style)'
    inputBinding:
      position: 102
      prefix: --cyk
  - id: backtrace
    type:
      - 'null'
      - boolean
    doc: use backtracing for the pretty print RHS of the product
    inputBinding:
      position: 102
      prefix: --backtrace
  - id: kbacktrace
    type:
      - 'null'
      - boolean
    doc: backtracing for k-scoring lhs
    inputBinding:
      position: 102
      prefix: --kbacktrace
  - id: subopt_classify
    type:
      - 'null'
      - boolean
    doc: classified dp
    inputBinding:
      position: 102
      prefix: --subopt-classify
  - id: subopt
    type:
      - 'null'
      - boolean
    doc: generate suboptimal backtracing code (needs foo * pretty)
    inputBinding:
      position: 102
      prefix: --subopt
  - id: sample
    type:
      - 'null'
      - boolean
    doc: generate stochastic backtracing code
    inputBinding:
      position: 102
      prefix: --sample
  - id: no_coopt
    type:
      - 'null'
      - boolean
    doc: with kbacktrace, don't output cooptimal candidates
    inputBinding:
      position: 102
      prefix: --no-coopt
  - id: no_coopt_class
    type:
      - 'null'
      - boolean
    doc: with kbacktrace, don't output cooptimal candidates
    inputBinding:
      position: 102
      prefix: --no-coopt-class
  - id: window_mode
    type:
      - 'null'
      - boolean
    doc: window mode
    inputBinding:
      position: 102
      prefix: --window-mode
  - id: kbest
    type:
      - 'null'
      - boolean
    doc: classify the k-best classes only
    inputBinding:
      position: 102
      prefix: --kbest
  - id: ambiguity
    type:
      - 'null'
      - boolean
    doc: converts the selected instance into a context free string grammar
    inputBinding:
      position: 102
      prefix: --ambiguity
  - id: specialize_grammar
    type:
      - 'null'
      - boolean
    doc: uses the selected instance and creates a GAP program which creates specialized
      GAP programs that recognize a subset of candidates of the original grammar.
    inputBinding:
      position: 102
      prefix: --specialize_grammar
  - id: outside_grammar
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --outside_grammar
    doc: generate an outside version of the grammar and report outside results for
      these inside non-terminals ("ALL" for all non-terminals)
    inputBinding:
      position: 102
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show suppressed warnings and messages
    inputBinding:
      position: 102
      prefix: --verbose
  - id: log_level
    type:
      - 'null'
      - int
    doc: the log level, valid values are 0 (VERBOSE), 1 (INFO), 2 (NORMAL), 3 (WARNING),
      4 (ERROR). Default is 2 (NORMAL).
    inputBinding:
      position: 102
      prefix: --log-level
  - id: include_dir
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: --include
    doc: include path
    inputBinding:
      position: 102
  - id: pareto_version
    type:
      - 'null'
      - int
    doc: Implementation of Pareto Product to use 0 (NoSort), 1 (Sort), 2 (ISort),
      3 (MultiDimOptimized), 4 (NoSort, domination ordered)
    inputBinding:
      position: 102
      prefix: --pareto-version
  - id: multi_dim_pareto
    type:
      - 'null'
      - boolean
    doc: Use multi-dimensional Pareto. Works with -P 0, -P 1 and -P 3.
    inputBinding:
      position: 102
      prefix: --multi-dim-pareto
  - id: cut_off
    type:
      - 'null'
      - int
    doc: The cut-off value for -P 3 option (65 default).
    inputBinding:
      position: 102
      prefix: --cut-off
  - id: float_accuracy
    type:
      - 'null'
      - int
    doc: The number of decimal places regarded for pareto and sorting procedures.
    inputBinding:
      position: 102
      prefix: --float-accuracy
  - id: specialized_adp
    type:
      - 'null'
      - int
    doc: 'Set to generate specialized implementations of the ADP framework: 0 (Standard),
      1 (Sorted ADP), 2 (Pareto Eager ADP)'
    inputBinding:
      position: 102
      prefix: --specialized-adp
  - id: step_mode
    type:
      - 'null'
      - int
    doc: 'Mode of specialization: 0 force block mode, 1 force stepwise mode.'
    inputBinding:
      position: 102
      prefix: --step-mode
  - id: plot_grammar
    type:
      - 'null'
      - int
    doc: generates a Graphviz dot-file from the selected grammar. Level of detail
      0 (default, no output) to 5.
    inputBinding:
      position: 102
      prefix: --plot-grammar
  - id: checkpoint
    type:
      - 'null'
      - boolean
    doc: enable periodic checkpointing of program progress.
    inputBinding:
      position: 102
      prefix: --checkpoint
outputs:
  - id: generated_code
    type:
      type: array
      items: File
    doc: Generated C++ source, header and makefile (NAME.cc, NAME.hh, NAME.mf)
    outputBinding:
      glob: |-
        ${
          var b = (inputs.output_name || "out.cc").replace(/\.cc$/, "");
          return [b + ".cc", b + ".hh", b + ".mf"];
        }
  - id: grammar_plot
    type:
      type: array
      items: File
    doc: Graphviz dot-file written with plot_grammar
    outputBinding:
      glob: '*.dot'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bellmans-gapc:2024.01.12--h3053a90_5
