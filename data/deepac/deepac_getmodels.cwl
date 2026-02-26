cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac_getmodels
label: deepac_getmodels
doc: "Rebuilds or fetches deep learning models for deep-AMR.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: download_only
    type:
      - 'null'
      - boolean
    doc: Fetch weights and config files but do not compile the models.
    inputBinding:
      position: 101
      prefix: --download-only
  - id: fetch
    type:
      - 'null'
      - boolean
    doc: Fetch and compile the latest models and configs from the online 
      repository.
    inputBinding:
      position: 101
      prefix: --fetch
  - id: rapid
    type:
      - 'null'
      - boolean
    doc: Rebuild the rapid CNN model.
    inputBinding:
      position: 101
      prefix: --rapid
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: Rebuild the sensitive model.
    inputBinding:
      position: 101
      prefix: --sensitive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_getmodels.out
