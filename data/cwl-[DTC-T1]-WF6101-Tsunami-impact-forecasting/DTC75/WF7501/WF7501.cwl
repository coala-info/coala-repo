#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

# Define global inputs.
inputs:
  DT7501:
    doc: "CSEM model data."
    type: File
  External_Data_Center:
    doc: "Stream from FDNS service."
    type: File
    streamable: true
  Run_User_Model:
    doc: "Flag to run user provided model."
    type: boolean
  UserModel:
    doc: "User provided model for update."
    type: File

# Define global outputs.
outputs:
  DT7501:
    doc: "Updated CSEM model"
    type: File
    outputSource: ST750105/DT7501_Updated

steps:
    ST750101:
      doc: "Data Catalog Update – Integrate external data into the workflow."
      in:
        External_Data_Center: External_Data_Center
      run:
        class: Operation
        inputs:
          External_Data_Center: File
        outputs:
          DataCatalog: File
      out:
        - DataCatalog

    ST750102:
      doc: "Inversion Setup – Configure inversion parameters."
      in:
        DataCatalog: ST750101/DataCatalog
      run:
        class: Operation
        inputs:
          DataCatalog: File
        outputs:
          InversionParameters: File
      out:
        - InversionParameters

    ST750103:
      doc: "Model Extraction – Extract models for inversion."
      in:
        DT7501: DT7501
        InversionParameters: ST750102/InversionParameters
      run:
        class: Operation
        inputs:
          DT7501: File
          InversionParameters: File
        outputs:
          ExtractedModel: File
      out:
        - ExtractedModel

    ST750104:
      doc: "Inversion Iterations – Perform iterative model refinements."
      in:
        ExtractedModel: ST750103/ExtractedModel
      run:
        class: Workflow
        inputs:
          ExtractedModel: File
        outputs:
          RefinedModel: File
        steps:
          SS7501:
            doc: "Salvus software used as forward code within inversion."
            in:
              ExtractedModel: ExtractedModel
            run:
              class: Operation
              inputs:
                ExtractedModel: File
              outputs:
                RefinedModel: File
            out:
              - RefinedModel
      out:
        - RefinedModel

    ST750105:
      doc: "Model Update – Apply inversion results to update the model."
      in:
        RefinedModel: ST750104/RefinedModel
        UserModel_Validated: 
            source: ST750106/UserModel_Validated
            pickValue: first_non_null
      run:
        class: Operation
        inputs:
          RefinedModel: File
          UserModel_Validated: ["null", File]
        outputs:
          DT7501_Updated: File
      out:
        - DT7501_Updated

    ST750106:
      doc: "User Model Validation – External user provides model."
      in:
        UserModel: UserModel
      when: $(inputs.Run_User_Model)
      run:
        class: Operation
        inputs:
          UserModel: File
        outputs:
          UserModel_Validated: File
      out:
        - UserModel_Validated
