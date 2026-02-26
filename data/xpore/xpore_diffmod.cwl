cwlVersion: v1.2
class: CommandLineTool
baseCommand: xpore_diffmod
label: xpore_diffmod
doc: "Performs differential modification analysis.\n\nTool homepage: https://github.com/GoekeLab/xpore"
inputs:
  - id: config
    type: File
    doc: YAML configuraion filepath.
    inputBinding:
      position: 101
      prefix: --config
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: gene or transcript ids to model.
    inputBinding:
      position: 101
      prefix: --ids
  - id: n_processes
    type:
      - 'null'
      - int
    doc: number of processes to run.
    inputBinding:
      position: 101
      prefix: --n_processes
  - id: resume
    type:
      - 'null'
      - boolean
    doc: with this argument, the program will resume from the previous run.
    inputBinding:
      position: 101
      prefix: --resume
  - id: save_models
    type:
      - 'null'
      - boolean
    doc: with this argument, the program will save the model parameters for each
      id.
    inputBinding:
      position: 101
      prefix: --save_models
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0
stdout: xpore_diffmod.out
