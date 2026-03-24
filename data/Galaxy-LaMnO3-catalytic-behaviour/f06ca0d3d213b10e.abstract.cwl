class: Workflow
label: LaMnO3 Catalytic Behaviour
cwlVersion: v1.2
inputs:
  'Upload: Figure 2-5_ Mn_K_edge_LMOA_time_series.prj':
    id: 'Upload: Figure 2-5_ Mn_K_edge_LMOA_time_series.prj'
    type: File
  'Upload: Figure 2-5_ La_L3_edge_LMOA_time_series.prj':
    id: 'Upload: Figure 2-5_ La_L3_edge_LMOA_time_series.prj'
    type: File
  mp-565203_Mn2O3.cif:
    id: mp-565203_Mn2O3.cif
    type: File
  1667441.cif:
    id: 1667441.cif
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
        source: 'Upload: Figure 2-5_ Mn_K_edge_LMOA_time_series.prj'
    out: []
  '5':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 'Upload: Figure 2-5_ Mn_K_edge_LMOA_time_series.prj'
    out: []
  '6':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: 'Upload: Figure 2-5_ La_L3_edge_LMOA_time_series.prj'
    out: []
  '7':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      format|structure_file:
        source: mp-565203_Mn2O3.cif
    out: []
  '8':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      format|structure_file:
        source: 1667441.cif
    out: []
  '9':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source: 4/athena_project_file_collection
    out: []
  '10':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source: 4/athena_project_file_collection
    out: []
  '11':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source: 6/athena_project_file_collection
    out: []
  '12':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source: 6/athena_project_file_collection
    out: []
  '13':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      feff_outputs_0|paths_zip:
        source: 7/out_dir
      feff_outputs_0|paths_file:
        source: 7/out_csv
    out: []
  '14':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      feff_outputs_0|paths_zip:
        source: 8/out_dir
      feff_outputs_0|paths_file:
        source: 8/out_csv
    out: []
  '15':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      gds_file:
        source: 13/gds_csv
      sp_file:
        source: 13/sp_csv
      feff_paths:
        source: 7/out_dir
      execution|prj_file:
        source: 4/athena_project_file_collection
    out: []
  '16':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      gds_file:
        source: 14/gds_csv
      sp_file:
        source: 14/sp_csv
      feff_paths:
        source: 8/out_dir
      execution|prj_file:
        source: 5/athena_project_file
    out: []
