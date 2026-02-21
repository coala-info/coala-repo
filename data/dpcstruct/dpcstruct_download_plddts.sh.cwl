cwlVersion: v1.2
class: CommandLineTool
baseCommand: dpcstruct_download_plddts.sh
label: dpcstruct_download_plddts.sh
doc: "Download pLDDT scores for dpcstruct (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/RitAreaSciencePark/DPCstruct"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
stdout: dpcstruct_download_plddts.sh.out
