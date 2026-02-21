cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakedeploy
label: snakedeploy
doc: "The provided text appears to be a container execution error log rather than
  help text. No usage information or arguments could be extracted from the input.\n
  \nTool homepage: https://github.com/snakemake/snakedeploy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakedeploy:0.15.0--pyhdfd78af_0
stdout: snakedeploy.out
