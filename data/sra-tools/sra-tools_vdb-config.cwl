cwlVersion: v1.2
class: CommandLineTool
baseCommand: vdb-config
label: sra-tools_vdb-config
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container image build or fetch operation.\n\nTool homepage:
  https://github.com/ncbi/sra-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools_vdb-config.out
