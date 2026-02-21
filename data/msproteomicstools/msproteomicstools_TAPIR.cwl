cwlVersion: v1.2
class: CommandLineTool
baseCommand: TAPIR
label: msproteomicstools_TAPIR
doc: "The provided text does not contain help information for the tool, but rather
  an error message regarding a container runtime failure (no space left on device).
  No arguments could be extracted.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h8b767f7_4
stdout: msproteomicstools_TAPIR.out
