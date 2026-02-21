cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromeister_compute_score.R
label: chromeister_compute_score.R
doc: "A tool to compute scores for Chromeister (Note: The provided help text contains
  only system error logs and no argument definitions).\n\nTool homepage: https://github.com/estebanpw/chromeister"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
stdout: chromeister_compute_score.R.out
