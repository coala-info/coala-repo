class: Workflow
label: Workflow to reproduce paper 8 EXAFS fitting
cwlVersion: v1.2
inputs:
  Washcoat Athena project file from paper:
    id: Washcoat Athena project file from paper
    type: File
  20g ash Athena project file from paper:
    id: 20g ash Athena project file from paper
    type: File
  PdO cif file:
    id: PdO cif file
    type: File
  Pd cif file:
    id: Pd cif file
    type: File
outputs: {}
steps:
  '4':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: Washcoat Athena project file from paper
    out: []
  '5':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 20g ash Athena project file from paper
    out: []
  '6':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      format|structure_file:
        source: PdO cif file
    out: []
  '7':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      format|structure_file:
        source: Pd cif file
    out: []
  '8':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      feff_outputs_0|paths_zip:
        source: 6/out_dir
      feff_outputs_1|paths_file:
        source: 7/out_csv
      feff_outputs_1|paths_zip:
        source: 7/out_dir
      feff_outputs_0|paths_file:
        source: 6/out_csv
    out: []
  '9':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      gds_file:
        source: 8/gds_csv
      sp_file:
        source: 8/sp_csv
      feff_paths:
        source: 8/merged_directories
      execution|prj_file:
        source: 4/athena_project_file_collection
    out: []
  '10':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      gds_file:
        source: 8/gds_csv
      sp_file:
        source: 8/sp_csv
      feff_paths:
        source: 8/merged_directories
      execution|prj_file:
        source: 5/athena_project_file_collection
    out: []
