class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'This workflow generates binding scores that correlate well with binding affinities using an additional tool SuCOS Max, developed at Oxford University. More info can be found at https://covid19.galaxyproject.org/cheminformatics/'
inputs:
  0_Input Dataset Collection:
    format: data
    type: File
  1_Input Dataset:
    format: data
    type: File
outputs: {}
steps:
  2_Collapse Collection:
    in:
      input_list: 0_Input Dataset Collection
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
  3_SDF sort and filter:
    in:
      input: 2_Collapse Collection/output
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_rdock_sort_filter_rdock_sort_filter_0_1_0
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: sdf
          type: File
  4_Split file:
    in:
      split_parms|input: 3_SDF sort and filter/output
    out:
    - list_output_sdf
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_split_file_to_collection_split_file_to_collection_0_4_0
      inputs:
        split_parms|input:
          format: Any
          type: File
      outputs:
        list_output_sdf:
          doc: input
          type: File
  5_Max SuCOS score:
    in:
      clusters: 1_Input Dataset
      input: 4_Split file/list_output_sdf
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_sucos_max_score_sucos_max_score_0_2_0
      inputs:
        clusters:
          format: Any
          type: File
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: sdf
          type: File
  6_Collapse Collection:
    in:
      input_list: 5_Max SuCOS score/output
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

