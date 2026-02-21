cwlVersion: v1.2
class: CommandLineTool
baseCommand: pints_visualizer
label: pypints_pints_visualizer
doc: "A tool for visualizing PINTS (Peak Identification from NGS Transcription Start
  Site data) results. Note: The provided help text contains only system logs and error
  messages regarding a container build failure, so no specific arguments could be
  extracted.\n\nTool homepage: https://pints.yulab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypints:1.2.1--pyh7e72e81_0
stdout: pypints_pints_visualizer.out
