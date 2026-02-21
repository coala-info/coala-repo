cwlVersion: v1.2
class: CommandLineTool
baseCommand: snikt_snikt.R
label: snikt_snikt.R
doc: "The provided text appears to be a container execution log rather than CLI help
  text. No arguments or usage instructions could be extracted.\n\nTool homepage: https://github.com/piyuranjan/SNIKT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snikt:0.5.0--r44hdfd78af_3
stdout: snikt_snikt.R.out
