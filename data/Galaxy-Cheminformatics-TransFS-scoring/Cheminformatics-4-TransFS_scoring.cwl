class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'This workflow generates binding scores that correlate well with binding affinities using an additional tool TransFS, developed at Oxford University. More info can be found at https://covid19.galaxyproject.org/cheminformatics/'
inputs:
  0_Input Dataset:
    format: data
    type: File
  1_Input Dataset Collection:
    format: data
    type: File
outputs: {}
steps:
  2_Collapse Collection:
    in:
      input_list: 1_Input Dataset Collection
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
  3_Split file:
    in:
      split_parms|input: 2_Collapse Collection/output
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
  4_XChem TransFS pose scoring:
    in:
      ligands: 3_Split file/list_output_sdf
      receptor: 0_Input Dataset
    out:
    - output
    - predictions
    - output_receptors
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_xchem_transfs_scoring_xchem_transfs_scoring_0_2_0
      inputs:
        ligands:
          format: Any
          type: File
        receptor:
          format: Any
          type: File
      outputs:
        output:
          doc: sdf
          type: File
        output_receptors:
          doc: tar
          type: File
        predictions:
          doc: txt
          type: File

