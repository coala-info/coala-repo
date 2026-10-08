cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mrpast
  - model
label: mrpast_model
doc: "Builds and manipulates demographic models.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: model
    type: File
    doc: The model YAML file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Emit msprime demography debugger output for the given model
    inputBinding:
      position: 102
      prefix: --debug
  - id: to_demes_path
    type: string?
    inputBinding:
      position: 103
      prefix: --to-demes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: to_demes
    type:
      - 'null'
      - File
    doc: Write a Demes YAML file representing the model.
    outputBinding:
      glob: $(inputs.to_demes_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_model.out
