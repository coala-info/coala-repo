cwlVersion: v1.2
class: CommandLineTool
baseCommand: HPC.REPmask
label: damasker_HPC.REPmask
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker_HPC.REPmask.out
