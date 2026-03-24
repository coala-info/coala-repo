class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: Population
  and community metrics calculation from Biodiversity data'
inputs:
  0_Input Dataset:
    format: data
    type: File
  1_Input Dataset:
    format: data
    type: File
outputs: {}
steps:
  2_Calculate community metrics:
    in:
      input: 0_Input Dataset
    out:
    - output_community
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_pampa_communitymetrics_pampa_communitymetrics_0_0_1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output_community:
          doc: tabular
          type: File
  3_Calculate presence absence table:
    in:
      input: 0_Input Dataset
    out:
    - output_presabs
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_pampa_presabs_pampa_presabs_0_0_1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        output_presabs:
          doc: tabular
          type: File
  4_Compute GLM on community data:
    in:
      input_metric: 2_Calculate community metrics/output_community
      input_unitobs: 1_Input Dataset
    out:
    - output_summary
    - output_recap
    - output_rate
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_pampa_glmcomm_pampa_glmcomm_0_0_1
      inputs:
        input_metric:
          format: Any
          type: File
        input_unitobs:
          format: Any
          type: File
      outputs:
        output_rate:
          doc: txt
          type: File
        output_recap:
          doc: txt
          type: File
        output_summary:
          doc: tabular
          type: File
  5_Compute GLM on population data:
    in:
      input_metric: 3_Calculate presence absence table/output_presabs
      input_unitobs: 1_Input Dataset
    out:
    - output_summary
    - output_recap
    - output_rate
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_ecology_pampa_glmsp_pampa_glmsp_0_0_1
      inputs:
        input_metric:
          format: Any
          type: File
        input_unitobs:
          format: Any
          type: File
      outputs:
        output_rate:
          doc: txt
          type: File
        output_recap:
          doc: txt
          type: File
        output_summary:
          doc: tabular
          type: File

