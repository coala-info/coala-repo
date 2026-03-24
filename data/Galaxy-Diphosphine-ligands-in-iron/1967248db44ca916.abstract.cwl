class: Workflow
label: Paper_2_Diphosphine-WF
cwlVersion: v1.2
inputs:
  A data:
    id: A data
    type: File[]
  B data:
    id: B data
    type: File[]
  C data:
    id: C data
    type: File[]
  D data:
    id: D data
    type: File[]
  Fe Metal:
    id: Fe Metal
    type: File[]
  FeBr:
    id: FeBr
    type: File[]
  7a:
    id: 7a
    type: File[]
outputs: {}
steps:
  '7':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: A data
    out: []
  '8':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: B data
    out: []
  '9':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: C data
    out: []
  '10':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: D data
    out: []
  '11':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Fe Metal
    out: []
  '12':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: FeBr
    out: []
  '13':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: 7a
    out: []
  '14':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 7/athena_project_file
        - 8/athena_project_file
        - 9/athena_project_file
        - 10/athena_project_file
        - 11/athena_project_file
    out: []
  '15':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 7/athena_project_file
        - 8/athena_project_file
        - 9/athena_project_file
        - 10/athena_project_file
        - 11/athena_project_file
        - 12/athena_project_file
    out: []
  '16':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 7/athena_project_file
        - 8/athena_project_file
        - 9/athena_project_file
        - 10/athena_project_file
        - 11/athena_project_file
        - 12/athena_project_file
    out: []
  '17':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 7/athena_project_file
        - 8/athena_project_file
        - 9/athena_project_file
        - 10/athena_project_file
        - 13/athena_project_file
    out: []
