cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_getLabelPCTinEachFT.R
label: sipros_getLabelPCTinEachFT.R
doc: "The provided text does not contain help information for the tool; it contains
  container runtime logs and a fatal error message indicating a failure to fetch the
  Docker image.\n\nTool homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_getLabelPCTinEachFT.R.out
