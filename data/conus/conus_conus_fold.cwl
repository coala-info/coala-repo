cwlVersion: v1.2
class: CommandLineTool
baseCommand: conus_fold
label: conus_conus_fold
doc: "Single Sequence SCFG algorithms for RNA structure prediction\n\nTool homepage:
  http://eddylab.org/software/conus/"
inputs:
  - id: seqfile_in
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: ct_format
    type:
      - 'null'
      - boolean
    doc: Print ct output format for predicted structure
    inputBinding:
      position: 102
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debugging output
    inputBinding:
      position: 102
      prefix: -d
  - id: debug_fill_matrix
    type:
      - 'null'
      - boolean
    doc: Debugging, print fill matrix from cyk
    inputBinding:
      position: 102
      prefix: -f
  - id: debug_traceback
    type:
      - 'null'
      - boolean
    doc: Debugging, print traceback
    inputBinding:
      position: 102
      prefix: -t
  - id: flat_scoring
    type:
      - 'null'
      - boolean
    doc: Flat scoring scheme (used with -g)
    inputBinding:
      position: 102
      prefix: --flat
  - id: grammar
    type:
      - 'null'
      - string
    doc: Use grammar <string> and plus one scoring (e.g., NUS, UNA, RUN, IVO, BJK,
      YRN, UYN, RY3, BK2)
    inputBinding:
      position: 102
      prefix: -g
  - id: hydrogen_bonding_scoring
    type:
      - 'null'
      - boolean
    doc: Shift to hydrogen bonding scoring (used with -g)
    inputBinding:
      position: 102
      prefix: -H
  - id: model_file
    type:
      - 'null'
      - File
    doc: Use model <file>
    inputBinding:
      position: 102
      prefix: -m
  - id: print_parameters
    type:
      - 'null'
      - boolean
    doc: Print out parameters of model
    inputBinding:
      position: 102
      prefix: -x
  - id: stockholm_format
    type:
      - 'null'
      - boolean
    doc: Print predicted structures in stockholm format
    inputBinding:
      position: 102
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Redirect structure output to <file>
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conus:1.0--h7b50bb2_6
