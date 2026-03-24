class: Workflow
label: Workflow Palladium CO Oxidation
cwlVersion: v1.2
inputs:
  100C_Helium.prj:
    id: 100C_Helium.prj
    type: File
  280C_without_H2.prj:
    id: 280C_without_H2.prj
    type: File
  280C_with_H2.prj:
    id: 280C_with_H2.prj
    type: File
outputs: {}
steps:
  '3':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 100C_Helium.prj
    out: []
  '4':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 100C_Helium.prj
    out: []
  '5':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 100C_Helium.prj
    out: []
  '6':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 280C_without_H2.prj
    out: []
  '7':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 280C_without_H2.prj
    out: []
  '8':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 280C_without_H2.prj
    out: []
  '9':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 280C_with_H2.prj
    out: []
  '10':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 280C_with_H2.prj
    out: []
  '11':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 280C_with_H2.prj
    out: []
  '12':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 3/athena_project_file
        - 4/athena_project_file
        - 5/athena_project_file
    out: []
  '13':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 6/athena_project_file
        - 7/athena_project_file
        - 8/athena_project_file
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
        - 9/athena_project_file
        - 10/athena_project_file
        - 11/athena_project_file
    out: []
