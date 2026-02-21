cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_haddock_haddock3_run
label: biobb_haddock_haddock3_run
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a system error log related to a failed container build (no
  space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_haddock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_haddock:5.2.0--pyhdfd78af_0
stdout: biobb_haddock_haddock3_run.out
