cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scn-train-model.R
label: singlecellnet-cli_scn-train-model.R
doc: "The provided text does not contain help information or a description of the
  tool. It contains container engine logs and a fatal error message regarding image
  retrieval.\n\nTool homepage: https://github.com/ebi-gene-expression-group/singlecellnet-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlecellnet-cli:0.0.1--hdfd78af_0
stdout: singlecellnet-cli_scn-train-model.R.out
