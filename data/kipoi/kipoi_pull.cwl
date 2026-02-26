cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi pull
label: kipoi_pull
doc: "Downloads the directory associated with the model.\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: model
    type: string
    doc: Model name. <model> can also refer to a model-group - e.g. if you 
      specify MaxEntScan then the dependencies for MaxEntScan/5prime and 
      MaxEntScan/3prime will be installed
    inputBinding:
      position: 1
  - id: source
    type:
      - 'null'
      - string
    doc: Model source to use (default=kipoi). Specified in ~/.kipoi/config.yaml 
      under model_sources. When 'dir' is used, use the local directory path when
      specifying the model/dataloader.
    default: kipoi
    inputBinding:
      position: 102
      prefix: --source
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_pull.out
