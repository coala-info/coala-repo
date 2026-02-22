cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangolearn
label: pangolearn
doc: "The pangolearn tool is used to manage and update the machine learning models
  used by Pangolin for SARS-CoV-2 lineage assignment.\n\nTool homepage: https://github.com/cov-lineages/pangoLEARN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangolearn:2022.03.22--pyh5e36f6f_0
stdout: pangolearn.out
