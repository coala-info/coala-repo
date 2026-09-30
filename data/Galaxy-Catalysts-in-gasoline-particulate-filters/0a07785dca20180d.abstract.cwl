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
      outputs:
        athena_project_file_collection:
          type: Any
    in:
      merge_inputs|format|dat_file:
        source: Washcoat Athena project file from paper
    out:
    - athena_project_file_collection
  '5':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs:
        athena_project_file_collection:
          type: Any
    in:
      merge_inputs|format|dat_file:
        source: 20g ash Athena project file from paper
    out:
    - athena_project_file_collection
  '6':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs:
        out_dir:
          type: Any
        out_csv:
          type: Any
    in:
      format|structure_file:
        source: PdO cif file
    out:
    - out_dir
    - out_csv
  '7':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs:
        out_csv:
          type: Any
        out_dir:
          type: Any
    in:
      format|structure_file:
        source: Pd cif file
    out:
    - out_csv
    - out_dir
  '8':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs:
        gds_csv:
          type: Any
        sp_csv:
          type: Any
        merged_directories:
          type: Any
    in:
      feff_outputs_0|paths_zip:
        source: 6/out_dir
      feff_outputs_1|paths_file:
        source: 7/out_csv
      feff_outputs_1|paths_zip:
        source: 7/out_dir
      feff_outputs_0|paths_file:
        source: 6/out_csv
    out:
    - gds_csv
    - sp_csv
    - merged_directories
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
