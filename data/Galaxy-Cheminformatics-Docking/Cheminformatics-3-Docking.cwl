class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Docking performed by rDock using as 3 different kind of inputs. More info can be found at https://covid19.galaxyproject.org/cheminformatics/'
inputs:
  0_Input Dataset:
    format: data
    type: File
  1_Input Dataset:
    format: data
    type: File
  2_Input Dataset Collection:
    format: data
    type: File
outputs: {}
steps:
  3_Compound conversion:
    in:
      infile: 0_Input Dataset
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_openbabel_compound_convert_openbabel_compound_convert_2_4_2_1_0
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: text
          type: File
  4_Concatenate datasets:
    in:
      inputs: 2_Input Dataset Collection
    out:
    - out_file1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_cat_0_1_0
      inputs:
        inputs:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  5_Split file:
    in:
      split_parms|input: 4_Concatenate datasets/out_file1
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
  6_rDock docking:
    in:
      active_site: 1_Input Dataset
      ligands: 5_Split file/list_output_sdf
      receptor: 3_Compound conversion/outfile
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_rdock_rbdock_rdock_rbdock_0_1_1
      inputs:
        active_site:
          format: Any
          type: File
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

