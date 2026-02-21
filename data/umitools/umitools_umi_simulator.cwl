cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umi_tools
  - simulator
label: umitools_umi_simulator
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/execution process.\n\nTool homepage:
  https://github.com/weng-lab/umitools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umitools:0.3.4--py36_0
stdout: umitools_umi_simulator.out
