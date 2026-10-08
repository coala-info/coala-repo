cwlVersion: v1.2
class: CommandLineTool
baseCommand: gadma-run_ls_on_boot_data
label: gadma_gadma-run_ls_on_boot_data
doc: "GADMA module for runs of local search on bootstrapped data. Is needed for calculating confidence intervals.\n\nTool homepage: https://github.com/ctlab/GADMA"
inputs:
  - id: boots
    type: Directory
    doc: 'Directory where bootstrapped data is located.'
    inputBinding:
      position: 1
      prefix: --boots
  - id: dem_model
    type: File
    doc: 'File with demographic model. Should contain `model_func` or `generated_model` function.'
    inputBinding:
      position: 1
      prefix: --dem_model
  - id: output_path
    type: string
    doc: 'Output directory.'
    inputBinding:
      position: 1
      prefix: --output
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'Number of threads for parallel run.'
    inputBinding:
      position: 2
      prefix: --jobs
  - id: opt
    type:
      - 'null'
      - string
    doc: 'Local search algorithm, by now it can be log (Inference.optimize_log) or powell (Inference.optimize_powell).'
    inputBinding:
      position: 2
      prefix: --opt
  - id: params
    type:
      - 'null'
      - File
    doc: 'Filename with parameters, should be valid python file.'
    inputBinding:
      position: 2
      prefix: --params
  - id: engine
    type:
      - 'null'
      - string
    doc: 'Engine to use for the demographic inference: dadi, moments or momentsLD.'
    inputBinding:
      position: 2
      prefix: --engine
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the local search results on the bootstrapped data
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
