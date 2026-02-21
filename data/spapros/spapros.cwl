cwlVersion: v1.2
class: CommandLineTool
baseCommand: spapros
label: spapros
doc: "Selection of optimal gene sets for spatial transcriptomics. (Note: The provided
  text appears to be a container build error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/theislab/spapros"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spapros:0.1.6--pyhdfd78af_0
stdout: spapros.out
