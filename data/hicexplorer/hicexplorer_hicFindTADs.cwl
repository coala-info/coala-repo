cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicFindTADs
label: hicexplorer_hicFindTADs
doc: "The provided text does not contain help information for hicFindTADs; it contains
  system logs and a fatal error indicating that the container build failed due to
  insufficient disk space. No arguments could be extracted from the provided text.\n
  \nTool homepage: https://github.com/deeptools/HiCExplorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicexplorer:3.7.6--pyhdfd78af_0
stdout: hicexplorer_hicFindTADs.out
