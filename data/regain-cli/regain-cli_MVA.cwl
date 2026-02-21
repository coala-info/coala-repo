cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regain-cli
  - MVA
label: regain-cli_MVA
doc: "The provided text does not contain help documentation for the tool; it consists
  of error logs from a failed container build process. No arguments or descriptions
  could be extracted.\n\nTool homepage: https://github.com/ERBringHorvath/regain_CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regain-cli:1.7.1--pyhdfd78af_0
stdout: regain-cli_MVA.out
