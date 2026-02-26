cwlVersion: v1.2
class: CommandLineTool
baseCommand: SigProfilerPlotting
label: sigprofilerplotting_SigProfilerPlotting
doc: "SigProfilerPlotting is a tool for plotting various types of genomic variations.\n\
  \nTool homepage: https://github.com/alexandrovlab/SigProfilerPlotting"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., plotSBS, plotID, plotDBS, plotSV, 
      plotCNV)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specific command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sigprofilerplotting:1.4.3--pyhdfd78af_0
stdout: sigprofilerplotting_SigProfilerPlotting.out
