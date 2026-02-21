cwlVersion: v1.2
class: CommandLineTool
baseCommand: BETA
label: cistrome_beta_BETA
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build or pull a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/hanfeisun/BETA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cistrome-ceas:1.0.2b1--py27_1
stdout: cistrome_beta_BETA.out
