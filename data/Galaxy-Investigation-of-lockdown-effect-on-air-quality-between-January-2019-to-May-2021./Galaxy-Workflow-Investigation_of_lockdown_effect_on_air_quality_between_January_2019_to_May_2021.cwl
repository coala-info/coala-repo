class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: Investigation
  of lockdown effect on air quality between January 2019 to May 2021: RELIANCE DS1-GC0-SC3'''
inputs: {}
outputs: {}
steps:
  0_NetCDF xarray Metadata Info:
    in: {}
    out:
    - output
    - info
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_metadata_info_xarray_metadata_info_0_18_2+galaxy0
      inputs: {}
      outputs:
        info:
          doc: txt
          type: File
        output:
          doc: tabular
          type: File
  10_Remove beginning:
    in:
      input: 5_NetCDF xarray Selection/simpleoutput
    out:
    - out_file1
    run:
      class: Operation
      id: Remove_beginning1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  11_Remove beginning:
    in:
      input: 6_NetCDF xarray Selection/simpleoutput
    out:
    - out_file1
    run:
      class: Operation
      id: Remove_beginning1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  12_Remove beginning:
    in:
      input: 7_NetCDF xarray Selection/simpleoutput
    out:
    - out_file1
    run:
      class: Operation
      id: Remove_beginning1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  13_Remove beginning:
    in:
      input: 8_NetCDF xarray Selection/simpleoutput
    out:
    - out_file1
    run:
      class: Operation
      id: Remove_beginning1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  14_Remove beginning:
    in:
      input: 9_NetCDF xarray Selection/simpleoutput
    out:
    - out_file1
    run:
      class: Operation
      id: Remove_beginning1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  15_Text reformatting:
    in:
      infile: 10_Remove beginning/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  16_Text reformatting:
    in:
      infile: 11_Remove beginning/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  17_Text reformatting:
    in:
      infile: 12_Remove beginning/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  18_Text reformatting:
    in:
      infile: 13_Remove beginning/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  19_Text reformatting:
    in:
      infile: 14_Remove beginning/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  1_NetCDF xarray Metadata Info:
    in: {}
    out:
    - output
    - info
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_metadata_info_xarray_metadata_info_0_18_2+galaxy0
      inputs: {}
      outputs:
        info:
          doc: txt
          type: File
        output:
          doc: tabular
          type: File
  20_Datamash:
    in:
      in_file: 15_Text reformatting/outfile
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
  21_Datamash:
    in:
      in_file: 15_Text reformatting/outfile
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
  22_Datamash:
    in:
      in_file: 15_Text reformatting/outfile
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
  23_Datamash:
    in:
      in_file: 16_Text reformatting/outfile
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
  24_Datamash:
    in:
      in_file: 16_Text reformatting/outfile
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
  25_Datamash:
    in:
      in_file: 16_Text reformatting/outfile
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
  26_Datamash:
    in:
      in_file: 17_Text reformatting/outfile
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
  27_Datamash:
    in:
      in_file: 17_Text reformatting/outfile
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
  28_Datamash:
    in:
      in_file: 17_Text reformatting/outfile
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
  29_Datamash:
    in:
      in_file: 18_Text reformatting/outfile
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
  2_NetCDF xarray Metadata Info:
    in: {}
    out:
    - output
    - info
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_metadata_info_xarray_metadata_info_0_18_2+galaxy0
      inputs: {}
      outputs:
        info:
          doc: txt
          type: File
        output:
          doc: tabular
          type: File
  30_Datamash:
    in:
      in_file: 18_Text reformatting/outfile
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
  31_Datamash:
    in:
      in_file: 18_Text reformatting/outfile
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
  32_Datamash:
    in:
      in_file: 19_Text reformatting/outfile
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
  33_Datamash:
    in:
      in_file: 19_Text reformatting/outfile
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
  34_Datamash:
    in:
      in_file: 19_Text reformatting/outfile
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
  35_Concatenate datasets:
    in:
      input1: 22_Datamash/out_file
      queries_0|input2: 23_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  36_Concatenate datasets:
    in:
      input1: 21_Datamash/out_file
      queries_0|input2: 24_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  37_Concatenate datasets:
    in:
      input1: 20_Datamash/out_file
      queries_0|input2: 25_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  38_Concatenate datasets:
    in:
      input1: 26_Datamash/out_file
      queries_0|input2: 29_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  39_Concatenate datasets:
    in:
      input1: 27_Datamash/out_file
      queries_0|input2: 30_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  3_NetCDF xarray Metadata Info:
    in: {}
    out:
    - output
    - info
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_metadata_info_xarray_metadata_info_0_18_2+galaxy0
      inputs: {}
      outputs:
        info:
          doc: txt
          type: File
        output:
          doc: tabular
          type: File
  40_Concatenate datasets:
    in:
      input1: 28_Datamash/out_file
      queries_0|input2: 31_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  41_Concatenate datasets:
    in:
      input1: 22_Datamash/out_file
      queries_0|input2: 23_Datamash/out_file
      queries_1|input2: 26_Datamash/out_file
      queries_2|input2: 29_Datamash/out_file
      queries_3|input2: 32_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
        queries_1|input2:
          format: Any
          type: File
        queries_2|input2:
          format: Any
          type: File
        queries_3|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  42_Concatenate datasets:
    in:
      input1: 21_Datamash/out_file
      queries_0|input2: 24_Datamash/out_file
      queries_1|input2: 27_Datamash/out_file
      queries_2|input2: 30_Datamash/out_file
      queries_3|input2: 33_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
        queries_1|input2:
          format: Any
          type: File
        queries_2|input2:
          format: Any
          type: File
        queries_3|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  43_Concatenate datasets:
    in:
      input1: 20_Datamash/out_file
      queries_0|input2: 25_Datamash/out_file
      queries_1|input2: 28_Datamash/out_file
      queries_2|input2: 31_Datamash/out_file
      queries_3|input2: 34_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
        queries_1|input2:
          format: Any
          type: File
        queries_2|input2:
          format: Any
          type: File
        queries_3|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  44_Paste:
    in:
      input1: 35_Concatenate datasets/out_file1
      input2: 38_Concatenate datasets/out_file1
    out:
    - out_file1
    run:
      class: Operation
      id: Paste1
      inputs:
        input1:
          format: Any
          type: File
        input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  45_Paste:
    in:
      input1: 36_Concatenate datasets/out_file1
      input2: 39_Concatenate datasets/out_file1
    out:
    - out_file1
    run:
      class: Operation
      id: Paste1
      inputs:
        input1:
          format: Any
          type: File
        input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  46_Paste:
    in:
      input1: 37_Concatenate datasets/out_file1
      input2: 40_Concatenate datasets/out_file1
    out:
    - out_file1
    run:
      class: Operation
      id: Paste1
      inputs:
        input1:
          format: Any
          type: File
        input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  47_Paste:
    in:
      input1: 44_Paste/out_file1
      input2: 32_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: Paste1
      inputs:
        input1:
          format: Any
          type: File
        input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  48_Paste:
    in:
      input1: 45_Paste/out_file1
      input2: 33_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: Paste1
      inputs:
        input1:
          format: Any
          type: File
        input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  49_Paste:
    in:
      input1: 46_Paste/out_file1
      input2: 34_Datamash/out_file
    out:
    - out_file1
    run:
      class: Operation
      id: Paste1
      inputs:
        input1:
          format: Any
          type: File
        input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  4_NetCDF xarray Metadata Info:
    in: {}
    out:
    - output
    - info
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_metadata_info_xarray_metadata_info_0_18_2+galaxy0
      inputs: {}
      outputs:
        info:
          doc: txt
          type: File
        output:
          doc: tabular
          type: File
  50_Text reformatting:
    in:
      infile: 47_Paste/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  51_Text reformatting:
    in:
      infile: 48_Paste/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  52_Text reformatting:
    in:
      infile: 49_Paste/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_awk_tool_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  5_NetCDF xarray Selection:
    in:
      var_tab: 0_NetCDF xarray Metadata Info/output
    out:
    - simpleoutput
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_select_xarray_select_0_18_2+galaxy0
      inputs:
        var_tab:
          format: Any
          type: File
      outputs:
        simpleoutput:
          doc: tabular
          type: File
  6_NetCDF xarray Selection:
    in:
      var_tab: 1_NetCDF xarray Metadata Info/output
    out:
    - simpleoutput
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_select_xarray_select_0_18_2+galaxy0
      inputs:
        var_tab:
          format: Any
          type: File
      outputs:
        simpleoutput:
          doc: tabular
          type: File
  7_NetCDF xarray Selection:
    in:
      var_tab: 2_NetCDF xarray Metadata Info/output
    out:
    - simpleoutput
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_select_xarray_select_0_18_2+galaxy0
      inputs:
        var_tab:
          format: Any
          type: File
      outputs:
        simpleoutput:
          doc: tabular
          type: File
  8_NetCDF xarray Selection:
    in:
      var_tab: 3_NetCDF xarray Metadata Info/output
    out:
    - simpleoutput
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_select_xarray_select_0_18_2+galaxy0
      inputs:
        var_tab:
          format: Any
          type: File
      outputs:
        simpleoutput:
          doc: tabular
          type: File
  9_NetCDF xarray Selection:
    in:
      var_tab: 4_NetCDF xarray Metadata Info/output
    out:
    - simpleoutput
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_xarray_select_xarray_select_0_18_2+galaxy0
      inputs:
        var_tab:
          format: Any
          type: File
      outputs:
        simpleoutput:
          doc: tabular
          type: File

