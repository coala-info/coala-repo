class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'This workflow generates a file describing the active site of the protein for each of the fragment screening crystal structures using rDock s rbcavity. It also creates a single hybrid molecule that contains all the ligands - the "frankenstein" ligand. More info can be found at https://covid19.galaxyproject.org/cheminformatics/'
inputs:
  Mpro-x0195_0_apo-desolv_pdb:
    format: data
    type: File
  hits_frankenstein_17_sdf:
    format: data
    type: File
outputs: {}
steps:
  2_Compound conversion:
    in:
      infile: Mpro-x0195_0_apo-desolv_pdb
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
  3_rDock cavity definition:
    in:
      ligand: hits_frankenstein_17_sdf
      receptor: 2_Compound conversion/outfile
    out:
    - activesite
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_rdock_rbcavity_rdock_rbcavity_0_1
      inputs:
        ligand:
          format: Any
          type: File
        receptor:
          format: Any
          type: File
      outputs:
        activesite:
          doc: rdock_as
          type: File

