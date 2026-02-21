cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfold
label: consan_sfold
doc: "Structural folding and alignment tool for sequences using parameters, grammar,
  and scoring models.\n\nTool homepage: http://eddylab.org/software/consan/"
inputs:
  - id: seqfile1
    type: File
    doc: First sequence file
    inputBinding:
      position: 1
  - id: seqfile2
    type: File
    doc: Second sequence file
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debugging output
    inputBinding:
      position: 103
      prefix: -d
  - id: full_algorithm
    type:
      - 'null'
      - boolean
    doc: execute full (unconstrained) algorithm / debugging, print fill matrix from
      cyk
    inputBinding:
      position: 103
      prefix: -f
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: Ensure that pin selection results in something near X Mbytes memory
    inputBinding:
      position: 103
      prefix: -M
  - id: model_file
    type:
      - 'null'
      - File
    doc: Use parameters, grammar and scoring specified in model <file>
    inputBinding:
      position: 103
      prefix: -m
  - id: predicted_pins
    type:
      - 'null'
      - int
    doc: use <int> predicted pins
    inputBinding:
      position: 103
      prefix: -P
  - id: print_parameters
    type:
      - 'null'
      - boolean
    doc: print out parameters of model
    inputBinding:
      position: 103
      prefix: -x
  - id: single_sequence_output
    type:
      - 'null'
      - boolean
    doc: output as single sequences rather than pair
    inputBinding:
      position: 103
      prefix: -V
  - id: traceback
    type:
      - 'null'
      - boolean
    doc: print traceback
    inputBinding:
      position: 103
      prefix: -t
  - id: trusted_pins
    type:
      - 'null'
      - int
    doc: use <int> pins from trusted alignment
    inputBinding:
      position: 103
      prefix: -C
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consan:1.2--h7b50bb2_7
stdout: consan_sfold.out
