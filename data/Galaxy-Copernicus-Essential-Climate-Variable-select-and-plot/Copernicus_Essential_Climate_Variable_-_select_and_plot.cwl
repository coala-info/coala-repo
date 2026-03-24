class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: Workflow
  with Copernicus Essential Climate Variable - select and plot'
inputs: {}
outputs: {}
steps:
  0_Copernicus Essential Climate Variables:
    in: {}
    out:
    - ofilename
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_climate_cds_essential_variability_cds_essential_variability_0_1_4
      inputs: {}
      outputs:
        ofilename:
          doc: netcdf
          type: File
  1_NetCDF xarray Metadata Info:
    in:
      input: 0_Copernicus Essential Climate Variables/ofilename
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
  2_NetCDF xarray Selection:
    in:
      input: 0_Copernicus Essential Climate Variables/ofilename
      var_tab: 1_NetCDF xarray Metadata Info/output
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
  3_Compute:
    in:
      input: 2_NetCDF xarray Selection/simpleoutput
    out:
    - out_file1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_devteam_column_maker_Add_a_column1_1_3_0
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  4_Text reformatting:
    in:
      infile: 3_Compute/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_1
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  5_Datamash:
    in:
      in_file: 4_Text reformatting/outfile
    out:
    - out_file
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_datamash_ops_datamash_ops_1_1_0
      inputs:
        in_file:
          format: Any
          type: File
      outputs:
        out_file:
          doc: tabular
          type: File
  6_Scatterplot with ggplot2:
    in:
      input1: 5_Datamash/out_file
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

