cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutmap_mutplot
label: mutmap_mutplot
doc: "A tool for plotting MutMap analysis results. (Note: The provided text is an
  error log and does not contain usage information or argument definitions.)\n\nTool
  homepage: https://github.com/YuSugihara/MutMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutmap:2.3.9--pyhdfd78af_0
stdout: mutmap_mutplot.out
