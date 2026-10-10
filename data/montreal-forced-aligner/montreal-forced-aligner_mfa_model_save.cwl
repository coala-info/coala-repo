cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - model
  - save
label: montreal-forced-aligner_mfa_model_save
doc: "Save a model to the pretrained folder for later use.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MFA_ROOT_DIR
        envValue: $(runtime.outdir)/mfa_root
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
    doc: "Type of the model."
    inputBinding:
      position: 1
  - id: model_path
    type: File
    doc: "Model file to save."
    inputBinding:
      position: 2
  - id: name
    type:
      - 'null'
      - string
    doc: "Name to use as reference (defaults to the name of the zip file)."
    inputBinding:
      position: 100
      prefix: --name
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite output files when they exist, default is False"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--overwrite" : "--no_overwrite"))'
outputs:
  - id: saved_model
    type: File
    doc: Saved model file in the MFA root directory.
    outputBinding:
      glob: mfa_root/pretrained_models/$(inputs.model_type)/*
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
