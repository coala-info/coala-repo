cwlVersion: v1.2
class: CommandLineTool
baseCommand: regain-cli
label: regain-cli_bnL
doc: "REGAIN (REgulatory Gene Association Networks) command-line interface for analyzing
  regulatory gene association networks.\n\nTool homepage: https://github.com/ERBringHorvath/regain_CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regain-cli:1.7.1--pyhdfd78af_0
stdout: regain-cli_bnL.out
