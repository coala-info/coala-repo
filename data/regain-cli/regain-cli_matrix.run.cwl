cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - regain-cli
  - matrix.run
label: regain-cli_matrix.run
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  failure.\n\nTool homepage: https://github.com/ERBringHorvath/regain_CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regain-cli:1.7.1--pyhdfd78af_0
stdout: regain-cli_matrix.run.out
