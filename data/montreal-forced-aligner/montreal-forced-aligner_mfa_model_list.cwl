cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - model
  - list
label: montreal-forced-aligner_mfa_model_list
doc: "List the locally saved models of a given type.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: MFA_ROOT_DIR
        envValue: $(runtime.outdir)/mfa_root
  - class: InitialWorkDirRequirement
    listing:
      - entryname: mfa_root
        entry: $(inputs.mfa_root_directory)
        writable: true
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
    doc: "Type of models to list."
    inputBinding:
      position: 1
  - id: mfa_root_directory
    type: Directory
    doc: MFA root directory (MFA_ROOT_DIR) that holds the saved models in pretrained_models/<model type>/.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
stdout: montreal-forced-aligner_mfa_model_list.out
