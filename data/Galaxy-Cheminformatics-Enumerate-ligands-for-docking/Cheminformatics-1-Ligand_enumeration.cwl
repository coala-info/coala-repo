class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'This workflow is used form the preparation of protein and ligands for docking. More info can be found at https://covid19.galaxyproject.org/cheminformatics/'
inputs:
  0_Input Dataset:
    format: data
    type: File
outputs: {}
steps:
  1_Enumerate changes:
    in:
      input: 0_Input Dataset
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_enumerate_charges_enumerate_charges_0_1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output:
          doc: smi
          type: File
  2_Split file:
    in:
      split_parms|input: 1_Enumerate changes/output
    out:
    - list_output_txt
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_split_file_to_collection_split_file_to_collection_0_4_0
      inputs:
        split_parms|input:
          format: Any
          type: File
      outputs:
        list_output_txt:
          doc: input
          type: File
  3_Compound conversion:
    in:
      infile: 2_Split file/list_output_txt
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
      input1: 3_Compound conversion/outfile
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File

