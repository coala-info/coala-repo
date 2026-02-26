cwlVersion: v1.2
class: CommandLineTool
baseCommand: vispr plot
label: vispr_plot
doc: "Plotting tool for vispr\n\nTool homepage: https://bitbucket.org/liulab/vispr"
inputs:
  - id: config
    type: string
    doc: Configuration file path
    inputBinding:
      position: 1
  - id: prefix
    type: string
    doc: Output file prefix
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
stdout: vispr_plot.out
