class: Workflow
label: Paper 9 N2O-LaMnO3 Figs1
cwlVersion: v1.2
inputs:
  Figure_1_XANES_time_series.prj:
    id: Figure_1_XANES_time_series.prj
    type: File
outputs: {}
steps:
  '1':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: Figure_1_XANES_time_series.prj
    out: []
  '2':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs:
        athena_project_file_collection:
          type: Any
    in:
      merge_inputs|format|dat_file:
        source: Figure_1_XANES_time_series.prj
    out:
    - athena_project_file_collection
  '3':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs:
        athena_project_file_collection:
          type: Any
    in:
      merge_inputs|format|dat_file:
        source: Figure_1_XANES_time_series.prj
    out:
    - athena_project_file_collection
  '4':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source: 2/athena_project_file_collection
    out: []
  '5':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source: 2/athena_project_file_collection
    out: []
  '6':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source: 3/athena_project_file_collection
    out: []
  '7':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source: 3/athena_project_file_collection
    out: []
