cwlVersion: v1.2
class: CommandLineTool
baseCommand: phenomenal-portal
label: phenomenal-portal
doc: "Phenomenal Portal (Note: The provided text contains system error logs regarding
  container image retrieval and does not contain command-line usage instructions or
  argument definitions).\n\nTool homepage: https://github.com/phenomenal-softwares/portal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/phenomenal-portal:phenomenal-v2.3.1_cv1.1.85
stdout: phenomenal-portal.out
