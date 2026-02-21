cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpiphy_generate_input_list
label: snpiphy_snpiphy_generate_input_list
doc: "The provided text does not contain help information for the tool. It contains
  container environment logs and a fatal error message regarding a failed OCI image
  build.\n\nTool homepage: https://github.com/bogemad/snpiphy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpiphy:0.5--py_0
stdout: snpiphy_snpiphy_generate_input_list.out
