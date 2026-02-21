cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromeister_compute_score-nogrid.R
label: chromeister_compute_score-nogrid.R
doc: "A script to compute scores for Chromeister (no-grid version). Note: The provided
  help text contains system error messages regarding container extraction and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/estebanpw/chromeister"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromeister:1.5.a--h7b50bb2_6
stdout: chromeister_compute_score-nogrid.R.out
