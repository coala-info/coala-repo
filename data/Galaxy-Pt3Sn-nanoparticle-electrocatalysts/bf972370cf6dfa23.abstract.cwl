class: Workflow
label: 'Paper 1: XANES, LCF, EXAFS'
cwlVersion: v1.2
inputs:
  Sn Foil:
    format:
    - prj
    id: Sn Foil
    type: File
  Sn foil Calibration:
    default: 29200.0
    id: Sn foil Calibration
    type: float?
  SnO2:
    format:
    - prj
    id: SnO2
    type: File
  SnO2 Calibration:
    default: 29219.73
    id: SnO2 Calibration
    type: float?
  Sn K edge H2 under H2:
    format:
    - tabular
    id: Sn K edge H2 under H2
    type: File[]
  Sn K edge under H2 Calibration:
    default: 29200.0
    id: Sn K edge under H2 Calibration
    type: float?
  Sn K edge H2:
    format:
    - tabular
    id: Sn K edge H2
    type: File[]
  Sn K edge Ar:
    format:
    - tabular
    id: Sn K edge Ar
    type: File[]
  Sn K edge Air:
    format:
    - tabular
    id: Sn K edge Air
    type: File[]
  Sn3Pt Sn Calibration:
    default: 29204.5
    id: Sn3Pt Sn Calibration
    type: float?
  Pt L3 edge H2 under H2:
    format:
    - tabular
    id: Pt L3 edge H2 under H2
    type: File[]
  Pt L3 edge under H2 Calibration:
    id: Pt L3 edge under H2 Calibration
    type: float?
  Pt L3 edge H2:
    format:
    - tabular
    id: Pt L3 edge H2
    type: File[]
  Pt L3 edge Ar:
    format:
    - tabular
    id: Pt L3 edge Ar
    type: File[]
  Pt L3 edge Air:
    format:
    - tabular
    id: Pt L3 edge Air
    type: File[]
  Sn3Pt Pt Calibration:
    id: Sn3Pt Pt Calibration
    type: float?
  Pt3Sn Cif:
    format:
    - cif
    id: Pt3Sn Cif
    type: File
  SnO2 Cif:
    format:
    - cif
    id: SnO2 Cif
    type: File
  PtO2 Cif:
    format:
    - cif
    id: PtO2 Cif
    type: File
outputs:
  _anonymous_output_1:
    outputSource: Sn foil Calibration
    type: File
  _anonymous_output_2:
    outputSource: SnO2 Calibration
    type: File
  _anonymous_output_3:
    outputSource: Sn K edge under H2 Calibration
    type: File
  _anonymous_output_4:
    outputSource: Sn3Pt Sn Calibration
    type: File
  _anonymous_output_5:
    outputSource: Pt L3 edge under H2 Calibration
    type: File
  _anonymous_output_6:
    outputSource: Sn3Pt Pt Calibration
    type: File
steps:
  Extract Sn Foil:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: Sn Foil
      processing|calibrate|calibration_e0:
        source: Sn foil Calibration
    out: []
  Extract SnO2:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|dat_file:
        source: SnO2
      processing|calibrate|calibration_e0:
        source: SnO2 Calibration
    out: []
  Merge Sn K edge H2 under H2:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Sn K edge H2 under H2
      processing|calibrate|calibration_e0:
        source: Sn K edge under H2 Calibration
    out: []
  Merge Sn K edge H2:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Sn K edge H2
      processing|calibrate|calibration_e0:
        source: Sn3Pt Sn Calibration
    out: []
  Merge Sn K edge Ar:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Sn K edge Ar
      processing|calibrate|calibration_e0:
        source: Sn3Pt Sn Calibration
    out: []
  Merge Sn K edge Air:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Sn K edge Air
      processing|calibrate|calibration_e0:
        source: Sn3Pt Sn Calibration
    out: []
  Merge Pt L3 edge H2 under H2:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Pt L3 edge H2 under H2
      processing|calibrate|calibration_e0:
        source: Pt L3 edge under H2 Calibration
    out: []
  Merge Pt L3 edge H2:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Pt L3 edge H2
      processing|calibrate|calibration_e0:
        source: Sn3Pt Pt Calibration
    out: []
  Merge Pt L3 edge Ar:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Pt L3 edge Ar
      processing|calibrate|calibration_e0:
        source: Sn3Pt Pt Calibration
    out: []
  Merge Pt L3 edge Air:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      merge_inputs|format|is_zipped|dat_file:
        source: Pt L3 edge Air
      processing|calibrate|calibration_e0:
        source: Sn3Pt Pt Calibration
    out: []
  'Pt3Sn FEFF: Sn':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      format|structure_file:
        source: Pt3Sn Cif
    out: []
  'Pt3Sn FEFF: Pt':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      format|structure_file:
        source: Pt3Sn Cif
    out: []
  SnO2 FEFF:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      format|structure_file:
        source: SnO2 Cif
    out: []
  PtO2 FEFF:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      format|structure_file:
        source: PtO2 Cif
    out: []
  'LCF: Sn Foil / SnO2, H2':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      components_0|component_file:
        source: Extract Sn Foil/athena_project_file
      components_1|component_file:
        source: Extract SnO2/athena_project_file
      execution|prj_file:
        source: Merge Sn K edge H2/athena_project_file
    out:
    - plot
  'LCF: Pt3Sn / SnO2, H2':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      components_0|component_file:
        source: Merge Sn K edge H2 under H2/athena_project_file
      components_1|component_file:
        source: Extract SnO2/athena_project_file
      execution|prj_file:
        source: Merge Sn K edge H2/athena_project_file
    out:
    - plot
  'LCF: Sn Foil / SnO2, Ar':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      components_0|component_file:
        source: Extract Sn Foil/athena_project_file
      components_1|component_file:
        source: Extract SnO2/athena_project_file
      execution|prj_file:
        source: Merge Sn K edge Ar/athena_project_file
    out:
    - plot
  'LCF: Pt3Sn / SnO2, Ar':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      components_0|component_file:
        source: Merge Sn K edge H2 under H2/athena_project_file
      components_1|component_file:
        source: Extract SnO2/athena_project_file
      execution|prj_file:
        source: Merge Sn K edge Ar/athena_project_file
    out:
    - plot
  Sn K XANES Plot:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - Extract Sn Foil/athena_project_file
        - Extract SnO2/athena_project_file
        - Merge Sn K edge H2 under H2/athena_project_file
        - Merge Sn K edge H2/athena_project_file
        - Merge Sn K edge Ar/athena_project_file
        - Merge Sn K edge Air/athena_project_file
    out: []
  'LCF: Sn Foil / SnO2, Air':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      components_0|component_file:
        source: Extract Sn Foil/athena_project_file
      components_1|component_file:
        source: Extract SnO2/athena_project_file
      execution|prj_file:
        source: Merge Sn K edge Air/athena_project_file
    out:
    - plot
  'LCF: Pt3Sn / SnO2, Air':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      components_0|component_file:
        source: Merge Sn K edge H2 under H2/athena_project_file
      components_1|component_file:
        source: Extract SnO2/athena_project_file
      execution|prj_file:
        source: Merge Sn K edge Air/athena_project_file
    out:
    - plot
  Pt L3 XANES Plot:
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      dat_files:
        source:
        - Merge Pt L3 edge H2 under H2/athena_project_file
        - Merge Pt L3 edge H2/athena_project_file
        - Merge Pt L3 edge Ar/athena_project_file
        - Merge Pt L3 edge Air/athena_project_file
    out: []
  '41':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      feff_outputs_3|paths_zip:
        source: PtO2 FEFF/out_dir
      feff_outputs_2|paths_file:
        source: SnO2 FEFF/out_csv
      feff_outputs_2|paths_zip:
        source: SnO2 FEFF/out_dir
      feff_outputs_0|paths_file:
        source: 'Pt3Sn FEFF: Sn/out_csv'
      feff_outputs_3|paths_file:
        source: PtO2 FEFF/out_csv
      feff_outputs_1|paths_file:
        source: 'Pt3Sn FEFF: Pt/out_csv'
      feff_outputs_1|paths_zip:
        source: 'Pt3Sn FEFF: Pt/out_dir'
      feff_outputs_0|paths_zip:
        source: 'Pt3Sn FEFF: Sn/out_dir'
    out: []
  'Artemis: H2 under H2':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      execution|simultaneous_0|prj_file:
        source: Merge Pt L3 edge H2 under H2/athena_project_file
      execution|simultaneous_1|prj_file:
        source: Merge Sn K edge H2 under H2/athena_project_file
      sp_file:
        source: 41/sp_csv
      gds_file:
        source: 41/gds_csv
      feff_paths:
        source: 41/merged_directories
    out: []
  'Artemis: H2':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      execution|simultaneous_0|prj_file:
        source: Merge Pt L3 edge H2/athena_project_file
      execution|simultaneous_1|prj_file:
        source: Merge Sn K edge H2/athena_project_file
      sp_file:
        source: 41/sp_csv
      gds_file:
        source: 41/gds_csv
      feff_paths:
        source: 41/merged_directories
    out: []
  'Artemis: Ar':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      execution|simultaneous_0|prj_file:
        source: Merge Pt L3 edge Ar/athena_project_file
      execution|simultaneous_1|prj_file:
        source: Merge Sn K edge Ar/athena_project_file
      sp_file:
        source: 41/sp_csv
      gds_file:
        source: 41/gds_csv
      feff_paths:
        source: 41/merged_directories
    out: []
  'Artemis: Air':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      execution|simultaneous_0|prj_file:
        source: Merge Pt L3 edge Air/athena_project_file
      execution|simultaneous_1|prj_file:
        source: Merge Sn K edge Air/athena_project_file
      sp_file:
        source: 41/sp_csv
      gds_file:
        source: 41/gds_csv
      feff_paths:
        source: 41/merged_directories
    out: []
