cwlVersion: v1.2
class: CommandLineTool
baseCommand: conus_train
label: conus_conus_train
doc: "Single Sequence SCFG algorithms for training models\n\nTool homepage: http://eddylab.org/software/conus/"
inputs:
  - id: training_set_files
    type:
      type: array
      items: File
    doc: Training set files
    inputBinding:
      position: 1
  - id: debugging_output
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
    doc: 'Use grammar <string>, defaults to NUS. Available codes: NUS, UNA, RUN, IVO,
      BJK, YRN, UYN, RY3, BK2'
    default: NUS
    inputBinding:
      position: 102
      prefix: -g
  - id: load_prior
    type:
      - 'null'
      - File
    doc: Load prior specified in <file>
    inputBinding:
      position: 102
      prefix: -l
  - id: print_parameters
    type:
      - 'null'
      - boolean
    doc: print out parameters of model
    inputBinding:
      position: 102
      prefix: -x
  - id: print_traceback
    type:
      - 'null'
      - boolean
    doc: print traceback
    inputBinding:
      position: 102
      prefix: -t
  - id: turn_off_plus_one_prior
    type:
      - 'null'
      - boolean
    doc: Turn off the standard plus one prior
    inputBinding:
      position: 102
      prefix: '-1'
  - id: verbose_output
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: save_model
    type:
      - 'null'
      - File
    doc: save model file to <file>; defaults to conus.mod
    outputBinding:
      glob: $(inputs.save_model)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conus:1.0--h7b50bb2_6
