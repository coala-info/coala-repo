cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvirs
label: mvirs_mvirs
doc: "Localisation of inducible prophages using NGS data\n\nTool homepage: https://github.com/SushiLab/mVIRs"
inputs:
  - id: command
    type: string
    doc: 'Command to run: index, oprs, or test'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the chosen command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvirs:1.1.1--pyhdfd78af_0
stdout: mvirs_mvirs.out
