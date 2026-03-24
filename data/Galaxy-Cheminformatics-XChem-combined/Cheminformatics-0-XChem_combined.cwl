class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'This workflow is used for the virtual screening of the SARS-CoV-2 main protease (de.NBI-cloud, STFC). It includes Charge enumeration, Generation of 3D conformations, Preparation of active site for docking using rDock, Docking, Scoring and Selection of compounds available. More info can be found at https://covid19.galaxyproject.org/cheminformatics/'
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
  3_Input Dataset:
    format: data
    type: File
outputs: {}
steps:
  4_XChem Docking:
    in:
      Active site: 1_Input Dataset
      Receptor: 0_Input Dataset
      input_ligands: 2_Input Dataset Collection
    out: []
    run:
      class: Operation
      id: a70961d36bd03ade
      inputs:
        Active site:
          format: Any
          type: File
        Receptor:
          format: Any
          type: File
        input_ligands:
          format: Any
          type: File
      outputs: {}
  5_XChem TransFS Scoring:
    in:
      1:Input dataset collection: 4_XChem Docking/Docked_Ligands
      Protein (PDB): 0_Input Dataset
    out: []
    run:
      class: Operation
      id: a1b8269b09176b2f
      inputs:
        1:Input dataset collection:
          format: Any
          type: File
        Protein (PDB):
          format: Any
          type: File
      outputs: {}
  6_XChem SuCOS Scoring:
    in:
      ligands to score: 5_XChem TransFS Scoring/4output
      reference molecules: 3_Input Dataset
    out: []
    run:
      class: Operation
      id: e660077a31d6ae70
      inputs:
        ligands to score:
          format: Any
          type: File
        reference molecules:
          format: Any
          type: File
      outputs: {}

