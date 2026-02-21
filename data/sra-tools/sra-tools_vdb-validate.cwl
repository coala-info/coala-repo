cwlVersion: v1.2
class: CommandLineTool
baseCommand: vdb-validate
label: sra-tools_vdb-validate
doc: "Validate the integrity of SRA data\n\nTool homepage: https://github.com/ncbi/sra-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools_vdb-validate.out
