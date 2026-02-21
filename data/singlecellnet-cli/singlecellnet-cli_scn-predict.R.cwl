cwlVersion: v1.2
class: CommandLineTool
baseCommand: scn-predict.R
label: singlecellnet-cli_scn-predict.R
doc: "A tool for predicting cell types using SingleCellNet. (Note: The provided help
  text contains only system error logs and no argument definitions.)\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/singlecellnet-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlecellnet-cli:0.0.1--hdfd78af_0
stdout: singlecellnet-cli_scn-predict.R.out
