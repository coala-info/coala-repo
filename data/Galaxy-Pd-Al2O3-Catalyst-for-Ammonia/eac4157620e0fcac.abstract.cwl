class: Workflow
label: Paper_6-PdAl2O3_100C_175C_300C
cwlVersion: v1.2
inputs:
  He_after_reduction.prj:
    id: He_after_reduction.prj
    type: File
  reaction-100C.prj:
    id: reaction-100C.prj
    type: File
  175C.prj:
    id: 175C.prj
    type: File
  300C.prj:
    id: 300C.prj
    type: File
outputs: {}
steps:
  Reduced sample:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: He_after_reduction.prj
    out: []
  100C PdO:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: reaction-100C.prj
    out: []
  100C Pd foil:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: reaction-100C.prj
    out: []
  100C position 0:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: reaction-100C.prj
    out: []
  100C position 8:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: reaction-100C.prj
    out: []
  175C PdO:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C Pd foil:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 8:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 0:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 1:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 2:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 3:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 4:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 5:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 6:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  175C position 7:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 175C.prj
    out: []
  300C PdO:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C Pd foil:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 0:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 8:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 1:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 2:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 3:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 4:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 5:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 6:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  300C position 7:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 300C.prj
    out: []
  After reduction:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - Reduced sample/athena_project_file
        - 100C PdO/athena_project_file
        - 100C Pd foil/athena_project_file
    out: []
  Pd/Al2O3 at 100C:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - Reduced sample/athena_project_file
        - 100C PdO/athena_project_file
        - 100C Pd foil/athena_project_file
        - 100C position 0/athena_project_file
        - 100C position 8/athena_project_file
    out: []
  Pd/Al2O3 at 175C:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 175C PdO/athena_project_file
        - 175C Pd foil/athena_project_file
        - 175C position 8/athena_project_file
        - 175C position 0/athena_project_file
    out: []
  Positions 0-8 at 175C:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 175C position 0/athena_project_file
        - 175C position 1/athena_project_file
        - 175C position 2/athena_project_file
        - 175C position 3/athena_project_file
        - 175C position 4/athena_project_file
        - 175C position 5/athena_project_file
        - 175C position 6/athena_project_file
        - 175C position 7/athena_project_file
    out: []
  Pd/Al2O3 at 300C:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 300C PdO/athena_project_file
        - 300C Pd foil/athena_project_file
        - 300C position 0/athena_project_file
        - 300C position 8/athena_project_file
    out: []
  Positions 0-8 at 300C:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - 300C position 0/athena_project_file
        - 300C position 8/athena_project_file
        - 300C position 1/athena_project_file
        - 300C position 2/athena_project_file
        - 300C position 3/athena_project_file
        - 300C position 4/athena_project_file
        - 300C position 5/athena_project_file
        - 300C position 6/athena_project_file
        - 300C position 7/athena_project_file
    out: []
