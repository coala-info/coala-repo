class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'This workflow combines SDF files from all fragments into a single dataset and filters to include only the lowest (best) scoring pose for each compound. This file of optimal poses for all ligands is used to compare to a database of Enamine and Chemspace compounds to select the best scoring 500 matches. More info can be found at https://covid19.galaxyproject.org/cheminformatics/'
inputs:
  0_Input Dataset Collection:
    format: data
    type: File
  1_Input Parameter:
    format: boolean
    type: integer
  2_Input Dataset:
    format: data
    type: File
outputs: {}
steps:
  10_Join:
    in:
      infile1: 9_Datamash/out_file
      infile2: 7_Filter/out_file1
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_easyjoin_tool_1_1_2
      inputs:
        infile1:
          format: Any
          type: File
        infile2:
          format: Any
          type: File
      outputs:
        output:
          doc: input
          type: File
  11_Sort:
    in:
      infile: 10_Join/output
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_sort_header_tool_1_1_1
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  12_Cut:
    in:
      input: 11_Sort/outfile
    out:
    - out_file1
    run:
      class: Operation
      id: Cut1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: tabular
          type: File
  13_Remove beginning:
    in:
      input: 12_Cut/out_file1
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
  14_Select first:
    in:
      count: 1_Input Parameter
      infile: 13_Remove beginning/out_file1
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_head_tool_1_1_0
      inputs:
        count:
          format: Any
          type: File
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  15_Filter:
    in:
      filter_methods|name_file: 14_Select first/outfile
      infile: 5_Collapse Collection/output
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_openbabel_filter_openbabel_filter_2_4_2_1_1
      inputs:
        filter_methods|name_file:
          format: Any
          type: File
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  3_Change title:
    in:
      infile: 0_Input Dataset Collection
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_openbabel_change_title_openbabel_change_title_2_4_2_1_1
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  4_JQ:
    in:
      input: 2_Input Dataset
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_jq_jq_1_0
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: json
          type: File
  5_Collapse Collection:
    in:
      input_list: 3_Change title/outfile
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_nml_collapse_collections_collapse_dataset_4_2
      inputs:
        input_list:
          format: Any
          type: File
      outputs:
        output:
          doc: input
          type: File
  6_Extract values from an SD-file:
    in:
      infile: 3_Change title/outfile
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_sdf_to_tab_sdf_to_tab_2019_03_1_1
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: tabular
          type: File
  7_Filter:
    in:
      input: 4_JQ/output
    out:
    - out_file1
    run:
      class: Operation
      id: Filter1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  8_Collapse Collection:
    in:
      input_list: 6_Extract values from an SD-file/outfile
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_nml_collapse_collections_collapse_dataset_4_2
      inputs:
        input_list:
          format: Any
          type: File
      outputs:
        output:
          doc: input
          type: File
  9_Datamash:
    in:
      in_file: 8_Collapse Collection/output
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

