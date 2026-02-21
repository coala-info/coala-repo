cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgsim_wgsim_eval.pl
label: wgsim_wgsim_eval.pl
doc: "Evaluation script for wgsim. (Note: The provided text contains container runtime
  error messages and does not include usage instructions or argument descriptions.)\n
  \nTool homepage: https://github.com/lh3/wgsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgsim:1.0--h577a1d6_10
stdout: wgsim_wgsim_eval.pl.out
