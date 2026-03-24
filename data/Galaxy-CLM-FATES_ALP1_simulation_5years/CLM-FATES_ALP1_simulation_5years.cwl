class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: CLM-FATES_
  ALP1 simulation (5 years)'
inputs:
  CLM-FATES restart file:
    format: data
    type: File
  Input dataset for CLM-FATES:
    format: data
    type: File
outputs: {}
steps:
  2_CTSM_FATES-EMERALD:
    in:
      adv_period|condi_type_run|restart: CLM-FATES restart file
      inputdata: Input dataset for CLM-FATES
    out:
    - history_files
    - atm_log
    - cesm_log
    - cpl_log
    - lnd_log
    - rof_log
    - restart
    - case_info
    - rinfo
    - work
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_climate_ctsm_fates_ctsm_fates_2_0_1
      inputs:
        adv_period|condi_type_run|restart:
          format: Any
          type: File
        inputdata:
          format: Any
          type: File
      outputs:
        atm_log:
          doc: txt
          type: File
        case_info:
          doc: txt
          type: File
        cesm_log:
          doc: txt
          type: File
        cpl_log:
          doc: txt
          type: File
        history_files:
          doc: input
          type: File
        lnd_log:
          doc: txt
          type: File
        restart:
          doc: tar
          type: File
        rinfo:
          doc: txt
          type: File
        rof_log:
          doc: txt
          type: File
        work:
          doc: tar
          type: File
  3_Extract Dataset:
    in:
      input: 2_CTSM_FATES-EMERALD/history_files
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
      input: 3_Extract Dataset/output
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
  5_NetCDF xarray Selection:
    in:
      input: 3_Extract Dataset/output
      var_tab: 4_NetCDF xarray Metadata Info/output
    out:
    - simpleoutput
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_select_xarray_select_0_15_1
      inputs:
        input:
          format: Any
          type: File
        var_tab:
          format: Any
          type: File
      outputs:
        simpleoutput:
          doc: tabular
          type: File
  6_Replace:
    in:
      infile: 5_NetCDF xarray Selection/simpleoutput
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_find_and_replace_1_1_3
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  7_Scatterplot with ggplot2:
    in:
      input1: 6_Replace/outfile
    out:
    - output1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_ggplot2_point_ggplot2_point_2_2_1+galaxy2
      inputs:
        input1:
          format: Any
          type: File
      outputs:
        output1:
          doc: png
          type: File

