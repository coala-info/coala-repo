cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop2
label: scallop-umi_scallop2
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log indicating a failure to fetch or build the OCI
  image for scallop-umi.\n\nTool homepage: https://github.com/Shao-Group/scallop-umi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop-umi:1.1.0--hbce0939_0
stdout: scallop-umi_scallop2.out
