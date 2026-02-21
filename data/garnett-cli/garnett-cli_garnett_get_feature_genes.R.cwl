cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - garnett_get_feature_genes.R
label: garnett-cli_garnett_get_feature_genes.R
doc: "A tool to get feature genes for Garnett. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli_garnett_get_feature_genes.R.out
