class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: Workflow
  for running a fully coupled CESM B1850 f19_g17'
inputs:
  inputdata_cesm_2_1_3_B1850_f19_g17_tar:
    doc: Input dataset for running this version of the fully coupled CESM model.
    format: data
    type: File
  user_nl_cam_rs:
    doc: User namelist for CAM (Atmosphere) restarts.
    format: data
    type: File
outputs: {}
steps:
  2_CESM:
    in:
      adv_atm|user_nl_atm_customization: user_nl_cam_rs
      input_type|inputdata: inputdata_cesm_2_1_3_B1850_f19_g17_tar
    out:
    - logs_files
    - history_files
    - work
    - restart
    - rinfo
    - case_info
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_climate_cesm_cesm_2_1_3+galaxy0
      inputs:
        adv_atm|user_nl_atm_customization:
          format: Any
          type: File
        input_type|inputdata:
          format: Any
          type: File
      outputs:
        case_info:
          doc: txt
          type: File
        history_files:
          doc: input
          type: File
        logs_files:
          doc: input
          type: File
        restart:
          doc: tar
          type: File
        rinfo:
          doc: txt
          type: File
        work:
          doc: tar
          type: File
  3_Extract dataset:
    in:
      input: 2_CESM/history_files
    out:
    - output
    run:
      class: Operation
      id: __EXTRACT_DATASET__
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: data
          type: File
  4_NetCDF xarray Metadata Info:
    in:
      input: 3_Extract dataset/output
    out:
    - output
    - info
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_metadata_info_xarray_metadata_info_0_15_1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        info:
          doc: txt
          type: File
        output:
          doc: tabular
          type: File
  5_NetCDF xarray map plotting:
    in:
      input: 3_Extract dataset/output
      var_tab: 4_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        input:
          format: Any
          type: File
        var_tab:
          format: Any
          type: File
      outputs:
        output_dir:
          doc: input
          type: File
        version:
          doc: tabular
          type: File

