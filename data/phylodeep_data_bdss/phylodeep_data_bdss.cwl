cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylodeep_data_bdss
label: phylodeep_data_bdss
doc: "A tool within the Phylodeep package (Note: The provided text contains system
  error messages regarding disk space and container image retrieval rather than command-line
  help documentation).\n\nTool homepage: https://github.com/evolbioinfo/phylodeep_data_bdss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
stdout: phylodeep_data_bdss.out
