cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - model
  - inspect
label: montreal-forced-aligner_mfa_model_inspect
doc: "Inspect a model and print out its metadata.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
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
  - id: model
    type:
      - File
      - string
    doc: "Model file (zip or dictionary), or the name of a saved model."
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
stdout: montreal-forced-aligner_mfa_model_inspect.out
