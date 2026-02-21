cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regain-cli
  - amrfinder
label: regain-cli_amrfinder
doc: "Antimicrobial Resistance (AMR) gene detection tool (Note: The provided text
  is a container build error log and does not contain usage information or argument
  definitions).\n\nTool homepage: https://github.com/ERBringHorvath/regain_CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regain-cli:1.7.1--pyhdfd78af_0
stdout: regain-cli_amrfinder.out
