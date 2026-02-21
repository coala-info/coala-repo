cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseqqc_filter.py
label: htseqqc_filter.py
doc: "A tool for filtering HTSeq QC results. (Note: The provided help text contains
  only system error messages and no usage information.)\n\nTool homepage: https://reneshbedre.github.io/blog/htseqqc.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseqqc:v1.0--pyh5bfb8f1_0
stdout: htseqqc_filter.py.out
