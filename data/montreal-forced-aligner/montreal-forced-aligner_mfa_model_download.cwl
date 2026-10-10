cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - model
  - download
label: montreal-forced-aligner_mfa_model_download
doc: "Download pretrained models from the MFA repository. If no model names are specified, the list of all downloadable models of the given model type is printed.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MFA_ROOT_DIR
        envValue: $(runtime.outdir)/mfa_root
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: model_type
    type:
      type: enum
      symbols:
        - acoustic
        - dictionary
        - g2p
        - ivector
        - language_model
        - tokenizer
    doc: "Type of model to download."
    inputBinding:
      position: 1
  - id: model_name
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names of the models to download."
    inputBinding:
      position: 2
  - id: github_token
    type:
      - 'null'
      - string
    doc: "Personal access token to use for requests to GitHub to increase rate limit."
    inputBinding:
      position: 100
      prefix: --github_token
  - id: version
    type:
      - 'null'
      - string
    doc: "Specific version of model to download rather than the latest."
    inputBinding:
      position: 100
      prefix: --version
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Flag to ignore existing downloaded models and force a re-download."
    inputBinding:
      position: 100
      prefix: --force
outputs:
  - id: models
    type:
      type: array
      items: File
    doc: Downloaded model files.
    outputBinding:
      glob: mfa_root/pretrained_models/$(inputs.model_type)/*
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
