class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: GTN ''Pangeo
  101 for everyone - Xarray'''
inputs:
  0_Input Parameter:
    format: text
    type: Text
  10_Input Parameter:
    format: text
    type: Text
  2_Input Parameter:
    format: text
    type: Text
  3_Input Parameter:
    format: text
    type: Text
  4_Input Parameter:
    format: text
    type: Text
  5_Input Parameter:
    format: text
    type: Text
  6_Input Parameter:
    format: text
    type: Text
  7_Input Parameter:
    format: text
    type: Text
  8_Input Parameter:
    format: text
    type: Text
  9_Input Parameter:
    format: text
    type: Text
  CAMS-PM2_5-20211222_netcdf:
    doc: 'netCDF input (4 days forecast) of PM2.5 from Copernicus Atmosphere Monitoring
      Service

      https://ads.atmosphere.copernicus.eu/#!/home


      As an example https://doi.org/10.5281/zenodo.5805953'
    format: data
    type: File
outputs: {}
steps:
  11_NetCDF xarray Coordinate Info:
    in:
      input: CAMS-PM2_5-20211222_netcdf
    out:
    - output_dir
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_coords_info_xarray_coords_info_0_18_2+galaxy0
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output_dir:
          doc: input
          type: File
  12_NetCDF xarray Metadata Info:
    in:
      input: CAMS-PM2_5-20211222_netcdf
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
  13_Extract dataset:
    in:
      input: 11_NetCDF xarray Coordinate Info/output_dir
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
  14_Extract dataset:
    in:
      input: 11_NetCDF xarray Coordinate Info/output_dir
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
  15_Extract dataset:
    in:
      input: 11_NetCDF xarray Coordinate Info/output_dir
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
  16_NetCDF xarray operations:
    in:
      input: CAMS-PM2_5-20211222_netcdf
      user_choice_0|dim_tab: 14_Extract dataset/output
      user_choice_1|dim_tab: 13_Extract dataset/output
      var_tab: 12_NetCDF xarray Metadata Info/output
    out:
    - output_netcdf
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_netcdf2netcdf_xarray_netcdf2netcdf_0_18_2+galaxy0
      inputs:
        input:
          format: Any
          type: File
        user_choice_0|dim_tab:
          format: Any
          type: File
        user_choice_1|dim_tab:
          format: Any
          type: File
        var_tab:
          format: Any
          type: File
      outputs:
        output_netcdf:
          doc: netcdf
          type: File
  17_NetCDF xarray operations:
    in:
      input: CAMS-PM2_5-20211222_netcdf
      user_choice_0|dim_tab: 15_Extract dataset/output
      var_tab: 12_NetCDF xarray Metadata Info/output
    out:
    - output_netcdf
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_netcdf2netcdf_xarray_netcdf2netcdf_0_18_2+galaxy0
      inputs:
        input:
          format: Any
          type: File
        user_choice_0|dim_tab:
          format: Any
          type: File
        var_tab:
          format: Any
          type: File
      outputs:
        output_netcdf:
          doc: netcdf
          type: File
  18_NetCDF xarray operations:
    in:
      input: CAMS-PM2_5-20211222_netcdf
      user_choice_0|dim_tab: 15_Extract dataset/output
      user_choice_1|dim_tab: 14_Extract dataset/output
      user_choice_2|dim_tab: 13_Extract dataset/output
      var_tab: 12_NetCDF xarray Metadata Info/output
    out:
    - output_netcdf
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_netcdf2netcdf_xarray_netcdf2netcdf_0_18_2+galaxy0
      inputs:
        input:
          format: Any
          type: File
        user_choice_0|dim_tab:
          format: Any
          type: File
        user_choice_1|dim_tab:
          format: Any
          type: File
        user_choice_2|dim_tab:
          format: Any
          type: File
        var_tab:
          format: Any
          type: File
      outputs:
        output_netcdf:
          doc: netcdf
          type: File
  19_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 15_Extract dataset/output
      condi_datetime|time_values: 0_Input Parameter
      input: CAMS-PM2_5-20211222_netcdf
      var_tab: 12_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  20_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 15_Extract dataset/output
      condi_datetime|time_values: 2_Input Parameter
      input: CAMS-PM2_5-20211222_netcdf
      var_tab: 12_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  21_NetCDF xarray Selection:
    in:
      input: 16_NetCDF xarray operations/output_netcdf
      var_tab: 12_NetCDF xarray Metadata Info/output
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
  22_NetCDF xarray Coordinate Info:
    in:
      input: 17_NetCDF xarray operations/output_netcdf
    out:
    - output_dir
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_coords_info_xarray_coords_info_0_18_2+galaxy0
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output_dir:
          doc: input
          type: File
  23_NetCDF xarray Coordinate Info:
    in:
      input: 18_NetCDF xarray operations/output_netcdf
    out:
    - output_dir
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_coords_info_xarray_coords_info_0_18_2+galaxy0
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output_dir:
          doc: input
          type: File
  24_NetCDF xarray Metadata Info:
    in:
      input: 18_NetCDF xarray operations/output_netcdf
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
  25_Column Regex Find And Replace:
    in:
      input: 21_NetCDF xarray Selection/simpleoutput
    out:
    - out_file1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_galaxyp_regex_find_replace_regexColumn1_1_0_1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  26_Scatterplot with ggplot2:
    in:
      input1: 21_NetCDF xarray Selection/simpleoutput
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
  27_Extract dataset:
    in:
      input: 22_NetCDF xarray Coordinate Info/output_dir
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
  28_Extract dataset:
    in:
      input: 23_NetCDF xarray Coordinate Info/output_dir
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
  29_climate stripes:
    in:
      ifilename: 25_Column Regex Find And Replace/out_file1
    out:
    - ofilename
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_climate_climate_stripes_climate_stripes_1_0_1
      inputs:
        ifilename:
          format: Any
          type: File
      outputs:
        ofilename:
          doc: png
          type: File
  30_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 27_Extract dataset/output
      condi_datetime|time_values: 0_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  31_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 6_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  32_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 8_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  33_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 5_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  34_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 9_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  35_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 4_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  36_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 7_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  37_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 3_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  38_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 3_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  39_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 4_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  40_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 10_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  41_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 5_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  42_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 6_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  43_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 10_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  44_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 7_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  45_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 9_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  46_NetCDF xarray map plotting:
    in:
      condi_datetime|time_tab: 28_Extract dataset/output
      condi_datetime|time_values: 8_Input Parameter
      input: 18_NetCDF xarray operations/output_netcdf
      var_tab: 24_NetCDF xarray Metadata Info/output
    out:
    - output_dir
    - version
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_mapplot_xarray_mapplot_0_18_2+galaxy0
      inputs:
        condi_datetime|time_tab:
          format: Any
          type: File
        condi_datetime|time_values:
          format: Any
          type: File
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
  47_Merge collections:
    in:
      inputs_0|input: 30_NetCDF xarray map plotting/output_dir
      inputs_1|input: 32_NetCDF xarray map plotting/output_dir
      inputs_2|input: 31_NetCDF xarray map plotting/output_dir
      inputs_3|input: 33_NetCDF xarray map plotting/output_dir
      inputs_4|input: 34_NetCDF xarray map plotting/output_dir
      inputs_5|input: 37_NetCDF xarray map plotting/output_dir
      inputs_6|input: 35_NetCDF xarray map plotting/output_dir
      inputs_7|input: 36_NetCDF xarray map plotting/output_dir
    out:
    - output
    run:
      class: Operation
      id: __MERGE_COLLECTION__
      inputs:
        inputs_0|input:
          format: Any
          type: File
        inputs_1|input:
          format: Any
          type: File
        inputs_2|input:
          format: Any
          type: File
        inputs_3|input:
          format: Any
          type: File
        inputs_4|input:
          format: Any
          type: File
        inputs_5|input:
          format: Any
          type: File
        inputs_6|input:
          format: Any
          type: File
        inputs_7|input:
          format: Any
          type: File
      outputs:
        output:
          doc: input
          type: File
  48_Merge collections:
    in:
      inputs_0|input: 43_NetCDF xarray map plotting/output_dir
      inputs_1|input: 46_NetCDF xarray map plotting/output_dir
      inputs_2|input: 42_NetCDF xarray map plotting/output_dir
      inputs_3|input: 41_NetCDF xarray map plotting/output_dir
      inputs_4|input: 45_NetCDF xarray map plotting/output_dir
      inputs_5|input: 38_NetCDF xarray map plotting/output_dir
      inputs_6|input: 39_NetCDF xarray map plotting/output_dir
      inputs_7|input: 44_NetCDF xarray map plotting/output_dir
    out:
    - output
    run:
      class: Operation
      id: __MERGE_COLLECTION__
      inputs:
        inputs_0|input:
          format: Any
          type: File
        inputs_1|input:
          format: Any
          type: File
        inputs_2|input:
          format: Any
          type: File
        inputs_3|input:
          format: Any
          type: File
        inputs_4|input:
          format: Any
          type: File
        inputs_5|input:
          format: Any
          type: File
        inputs_6|input:
          format: Any
          type: File
        inputs_7|input:
          format: Any
          type: File
      outputs:
        output:
          doc: input
          type: File
  49_Image Montage:
    in:
      input: 47_Merge collections/output
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_graphicsmagick_image_montage_graphicsmagick_image_montage_1_3_31+galaxy1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: png
          type: File
  50_Image Montage:
    in:
      input: 48_Merge collections/output
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_graphicsmagick_image_montage_graphicsmagick_image_montage_1_3_31+galaxy1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: png
          type: File

