cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regain-cli
  - regain
label: regain-cli_regain
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/fetch process.\n\nTool homepage: https://github.com/ERBringHorvath/regain_CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regain-cli:1.7.1--pyhdfd78af_0
stdout: regain-cli_regain.out
