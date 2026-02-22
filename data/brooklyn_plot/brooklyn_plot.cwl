cwlVersion: v1.2
class: CommandLineTool
baseCommand: brooklyn_plot
label: brooklyn_plot
doc: "Brooklyn plot tool (No help text provided in input)\n\nTool homepage: https://github.com/arunhpatil/brooklyn/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/brooklyn_plot:0.0.4--pyhdfd78af_0
stdout: brooklyn_plot.out
