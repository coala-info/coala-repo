cwlVersion: v1.2
class: CommandLineTool
baseCommand: reorder
label: conus_reorder
doc: "Reorder suboptimals for a sequence file using specified grammar or model parameters.\n
  \nTool homepage: http://eddylab.org/software/conus/"
inputs:
  - id: seq_file
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debugging output
    inputBinding:
      position: 102
      prefix: -d
  - id: grammar
    type:
      - 'null'
      - string
    doc: Use grammar <string>, defaults to NUS; ignored if model file specified
    inputBinding:
      position: 102
      prefix: -g
  - id: model_file
    type:
      - 'null'
      - File
    doc: Use parameters, grammar and scoring specified in model <file>
    inputBinding:
      position: 102
      prefix: -m
  - id: num_suboptimals
    type: int
    doc: number of suboptimals to reorder
    inputBinding:
      position: 102
      prefix: -b
  - id: print_fill_matrix
    type:
      - 'null'
      - boolean
    doc: debugging, print fill matrix from cyk
    inputBinding:
      position: 102
      prefix: -f
  - id: print_parameters
    type:
      - 'null'
      - boolean
    doc: print out parameters of model
    inputBinding:
      position: 102
      prefix: -x
  - id: print_parse_trees
    type:
      - 'null'
      - boolean
    doc: print all parse trees (lots!)
    inputBinding:
      position: 102
      prefix: -t
  - id: print_real_with_predicted
    type:
      - 'null'
      - boolean
    doc: print real with predicted structure
    inputBinding:
      position: 102
      prefix: -p
  - id: print_stockholm
    type:
      - 'null'
      - boolean
    doc: print predicted structures in stockholm format
    inputBinding:
      position: 102
      prefix: -q
  - id: report_better_than_cyk
    type:
      - 'null'
      - boolean
    doc: report on things better than CYK
    inputBinding:
      position: 102
      prefix: -c
  - id: report_suboptimals_table
    type:
      - 'null'
      - boolean
    doc: report all suboptimals table
    inputBinding:
      position: 102
      prefix: -a
  - id: report_tracebacks
    type:
      - 'null'
      - boolean
    doc: report tracebacks in CYK report (ignored if not with -c)
    inputBinding:
      position: 102
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conus:1.0--h7b50bb2_6
stdout: conus_reorder.out
