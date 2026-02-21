cwlVersion: v1.2
class: CommandLineTool
baseCommand: livekraken
label: livekraken
doc: "LiveKraken is a tool for real-time taxonomic classification of sequencing data.
  (Note: The provided text contains container runtime error messages rather than command-line
  help documentation.)\n\nTool homepage: https://gitlab.com/SimonHTausch/LiveKraken"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/livekraken:1.0--pl5321h9948957_12
stdout: livekraken.out
