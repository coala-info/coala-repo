class: Workflow
label: 'Workflow constructed from history ''''Extracting structural information of
  Au colloids at ultra-dilute concentrations: identification of growth during nanoparticle
  immobilization (paper-3'''''
cwlVersion: v1.2
inputs:
  Compiled_XAS_data_Colloid_and_TiO2_supported_Au.prj:
    id: Compiled_XAS_data_Colloid_and_TiO2_supported_Au.prj
    type: File
outputs: {}
steps:
  '1':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in: {}
    out: []
  '2':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in: {}
    out: []
  '3':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in: {}
    out: []
  '4':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in: {}
    out: []
  '5':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in: {}
    out: []
  '6':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in: {}
    out: []
  '7':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in: {}
    out: []
  '8':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: Compiled_XAS_data_Colloid_and_TiO2_supported_Au.prj
    out: []
  '9':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 1/athena_project_file
        - 2/athena_project_file
        - 3/athena_project_file
        - 4/athena_project_file
        - 5/athena_project_file
    out: []
  '10':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 1/athena_project_file
        - 2/athena_project_file
        - 6/athena_project_file
        - 7/athena_project_file
    out: []
