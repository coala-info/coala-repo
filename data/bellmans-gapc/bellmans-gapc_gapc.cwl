cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapc
label: bellmans-gapc_gapc
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/gapc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bellmans-gapc:2024.01.12--h0432e7c_1
stdout: bellmans-gapc_gapc.out
