cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-sample
label: tsv-utils_tsv-sample
doc: "Sample input lines or randomize their order (shuffling, random, weighted, Bernoulli and distinct sampling).\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input files. Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Treat the first line of each file as a header."
    inputBinding:
      position: 101
      prefix: -H
  - id: num
    type:
      - 'null'
      - int
    doc: "Maximum number of lines to output. All selected lines are output if not provided or zero."
    inputBinding:
      position: 101
      prefix: -n
  - id: prob
    type:
      - 'null'
      - float
    doc: "Inclusion probability (0.0 < NUM <= 1.0). For Bernoulli sampling, the probability each line is selected. For distinct sampling, the probability each unique key is selected."
    inputBinding:
      position: 101
      prefix: -p
  - id: key_fields
    type:
      - 'null'
      - string
    doc: "Fields to use as key for distinct sampling. Use with --prob. Use 0 to use the entire line as the key."
    inputBinding:
      position: 101
      prefix: -k
  - id: weight_field
    type:
      - 'null'
      - int
    doc: "Field containing weights. All lines get equal weight if not provided."
    inputBinding:
      position: 101
      prefix: -w
  - id: replace
    type:
      - 'null'
      - boolean
    doc: "Simple random sampling with replacement. Use --num to specify the sample size."
    inputBinding:
      position: 101
      prefix: -r
  - id: inorder
    type:
      - 'null'
      - boolean
    doc: "Output random samples in original input order. Requires use of --num."
    inputBinding:
      position: 101
      prefix: -i
  - id: static_seed
    type:
      - 'null'
      - boolean
    doc: "Use the same random seed every run."
    inputBinding:
      position: 101
      prefix: -s
  - id: seed_value
    type:
      - 'null'
      - int
    doc: "Sets the random seed. Use a non-zero, 32 bit positive integer. Zero is a no-op."
    inputBinding:
      position: 101
      prefix: -v
  - id: print_random
    type:
      - 'null'
      - boolean
    doc: "Include the assigned random value (prepended) when writing output lines."
    inputBinding:
      position: 101
      prefix: --print-random
  - id: gen_random_inorder
    type:
      - 'null'
      - boolean
    doc: "Output all lines with assigned random values prepended, no changes to the order of input."
    inputBinding:
      position: 101
      prefix: --gen-random-inorder
  - id: random_value_header
    type:
      - 'null'
      - string
    doc: "Header to use with --print-random and --gen-random-inorder. Default: 'random_value'."
    inputBinding:
      position: 101
      prefix: --random-value-header
  - id: compatibility_mode
    type:
      - 'null'
      - boolean
    doc: "Turns on 'compatibility-mode'."
    inputBinding:
      position: 101
      prefix: --compatibility-mode
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Field delimiter."
    inputBinding:
      position: 101
      prefix: -d
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: "Immediately output every sampled line. Applies to Bernoulli and distinct sampling."
    inputBinding:
      position: 101
      prefix: --line-buffered
outputs:
  - id: sample
    type: stdout
    doc: "Sampled or shuffled lines"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-sample_output.tsv
