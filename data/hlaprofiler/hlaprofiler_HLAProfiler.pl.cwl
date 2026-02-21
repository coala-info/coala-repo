cwlVersion: v1.2
class: CommandLineTool
baseCommand: hlaprofiler_HLAProfiler.pl
label: hlaprofiler_HLAProfiler.pl
doc: "HLA profiling tool (Note: The provided help text contains only system error
  messages and no usage information.)\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlaprofiler:1.0.5--0
stdout: hlaprofiler_HLAProfiler.pl.out
