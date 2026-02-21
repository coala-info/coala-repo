cwlVersion: v1.2
class: CommandLineTool
baseCommand: hlaprofiler
label: hlaprofiler
doc: "HLAProfiler is a tool for HLA typing from RNA-seq data. (Note: The provided
  help text contained only system error messages regarding container execution and
  did not list specific command-line arguments.)\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlaprofiler:1.0.5--0
stdout: hlaprofiler.out
