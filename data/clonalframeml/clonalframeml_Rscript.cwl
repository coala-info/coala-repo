cwlVersion: v1.2
class: CommandLineTool
baseCommand: clonalframeml_Rscript
label: clonalframeml_Rscript
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/xavierdidelot/ClonalFrameML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clonalframeml:1.13--h9948957_2
stdout: clonalframeml_Rscript.out
