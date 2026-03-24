class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: PATH2XNAT
  ST workflow Xenium non-diseased lung test data analysis'
inputs:
  Non_diseased_lung_minimal_RDS:
    format: data
    type: File
  Non_diseased_lung_minimal_zip:
    format: data
    type: File
  Xenium_hLung_v1_metadata_csv:
    format: data
    type: File
  test_RData:
    format: data
    type: File
  test_RHistory:
    format: data
    type: File
  workspace_RData:
    format: data
    type: File
  workspace_RHistory:
    format: data
    type: File
outputs: {}
steps:
  7_RStudio:
    in: {}
    out:
    - jupyter_notebook
    run:
      class: Operation
      id: interactive_tool_rstudio
      inputs: {}
      outputs:
        jupyter_notebook:
          doc: ipynb
          type: File

