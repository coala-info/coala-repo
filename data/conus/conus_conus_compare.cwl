cwlVersion: v1.2
class: CommandLineTool
baseCommand: conus_compare
label: conus_conus_compare
doc: "Single Sequence SCFG algorithms for comparing test files.\n\nTool homepage:
  http://eddylab.org/software/conus/"
inputs:
  - id: test_files
    type:
      type: array
      items: File
    doc: Test files to compare
    inputBinding:
      position: 1
  - id: cumulative_statistics
    type:
      - 'null'
      - boolean
    doc: give cumulative statistics (global)
    inputBinding:
      position: 102
      prefix: -a
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debugging output
    inputBinding:
      position: 102
      prefix: -d
  - id: debug_fill_matrix
    type:
      - 'null'
      - boolean
    doc: debugging, print fill matrix from cyk
    inputBinding:
      position: 102
      prefix: -f
  - id: debug_traceback
    type:
      - 'null'
      - boolean
    doc: debugging, print traceback
    inputBinding:
      position: 102
      prefix: -t
  - id: flat_scoring
    type:
      - 'null'
      - boolean
    doc: flat scoring scheme (with -g)
    inputBinding:
      position: 102
      prefix: --flat
  - id: grammar
    type:
      - 'null'
      - string
    doc: Use grammar <string> and plus one scoring
    inputBinding:
      position: 102
      prefix: -g
  - id: hydrogen_bonding_scoring
    type:
      - 'null'
      - boolean
    doc: shift to hydrogen bonding scoring (with -g)
    inputBinding:
      position: 102
      prefix: -H
  - id: mathews99_method
    type:
      - 'null'
      - boolean
    doc: Use the Mathews99 method of evaluation
    inputBinding:
      position: 102
      prefix: -M
  - id: model_file
    type:
      - 'null'
      - File
    doc: Use model <file>
    inputBinding:
      position: 102
      prefix: -m
  - id: output_structures
    type:
      - 'null'
      - boolean
    doc: output real and predicted structures
    inputBinding:
      position: 102
      prefix: -p
  - id: print_parameters
    type:
      - 'null'
      - boolean
    doc: print out parameters of model
    inputBinding:
      position: 102
      prefix: -x
  - id: sequence_statistics
    type:
      - 'null'
      - boolean
    doc: give statistics on each sequence (ignored in table mode)
    inputBinding:
      position: 102
      prefix: -i
  - id: stockholm_format
    type:
      - 'null'
      - boolean
    doc: output predicted structures in stockholm format
    inputBinding:
      position: 102
      prefix: -q
  - id: table_format
    type:
      - 'null'
      - boolean
    doc: output in table format
    inputBinding:
      position: 102
      prefix: -c
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
stdout: conus_conus_compare.out
