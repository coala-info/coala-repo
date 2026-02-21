cwlVersion: v1.2
class: CommandLineTool
baseCommand: regain-cli
label: regain-cli_bnS
doc: "REgional Association Identification (REGAIN) command-line interface for genomic
  analysis.\n\nTool homepage: https://github.com/ERBringHorvath/regain_CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regain-cli:1.7.1--pyhdfd78af_0
stdout: regain-cli_bnS.out
