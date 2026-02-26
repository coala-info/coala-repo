cwlVersion: v1.2
class: CommandLineTool
baseCommand: correlationplus
label: correlationplus_diffmap
doc: "A Python package to calculate, visualize and analyze protein correlation maps.\n\
  \nTool homepage: https://github.com/tekpinar/correlationplus"
inputs:
  - id: app
    type: string
    doc: The CorrelationPlus app to use (calculate, visualize, analyze, paths, 
      diffMap)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
stdout: correlationplus_diffmap.out
