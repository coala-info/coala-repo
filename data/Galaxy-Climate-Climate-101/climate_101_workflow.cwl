class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'The tutorial for this workflow can be found on [Galaxy Training Network](https://training.galaxyproject.org/training-material/topics/climate/tutorials/climate-101/tutorial.html)'
inputs:
  tg_ens_mean_0_1deg_reg_v20_0e_Paris_daily_csv:
    format: data
    type: File
  ts_cities_csv:
    format: data
    type: File
outputs: {}
steps:
  10_Datamash:
    in:
      in_file: 8_Text reformatting/outfile
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
  11_Datamash:
    in:
      in_file: 8_Text reformatting/outfile
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
  12_Datamash:
    in:
      in_file: 10_Datamash/out_file
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
  13_Datamash:
    in:
      in_file: 10_Datamash/out_file
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
  14_Scatterplot w ggplot2:
    in:
      input1: 11_Datamash/out_file
    out:
    - output1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_ggplot2_point_ggplot2_point_2_2_1+galaxy1
      inputs:
        input1:
          format: Any
          type: File
      outputs:
        output1:
          doc: png
          type: File
  2_Copernicus Essential Climate Variables:
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
  3_climate stripes:
    in:
      ifilename: ts_cities_csv
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
  4_Select:
    in:
      input: tg_ens_mean_0_1deg_reg_v20_0e_Paris_daily_csv
    out:
    - out_file1
    run:
      class: Operation
      id: Grep1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  5_Datamash:
    in:
      in_file: tg_ens_mean_0_1deg_reg_v20_0e_Paris_daily_csv
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
  6_Datamash:
    in:
      in_file: tg_ens_mean_0_1deg_reg_v20_0e_Paris_daily_csv
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
  7_Datamash:
    in:
      in_file: tg_ens_mean_0_1deg_reg_v20_0e_Paris_daily_csv
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
  8_Text reformatting:
    in:
      infile: tg_ens_mean_0_1deg_reg_v20_0e_Paris_daily_csv
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
  9_map plot:
    in:
      ifilename: 2_Copernicus Essential Climate Variables/ofilename
    out:
    - ofilename
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_climate_psy_maps_psy_maps_1_2_1
      inputs:
        ifilename:
          format: Any
          type: File
      outputs:
        ofilename:
          doc: png
          type: File

