cwlVersion: v1.2
class: CommandLineTool
baseCommand: amiga
label: amiga
doc: "A tool for analyzing growth curves, including fitting, summarizing, and comparing
  data.\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: command
    type: string
    doc: The amiga command to execute (summarize, fit, normalize, compare, test, heatmap,
      get_confidence, get_time, or print_defaults)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
stdout: amiga.out
