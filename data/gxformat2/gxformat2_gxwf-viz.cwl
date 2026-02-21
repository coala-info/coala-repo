cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxwf-viz
label: gxformat2_gxwf-viz
doc: "A tool for visualizing Galaxy workflows. (Note: The provided help text contains
  only system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/jmchilton/gxformat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxformat2:0.21.0--pyhdfd78af_0
stdout: gxformat2_gxwf-viz.out
