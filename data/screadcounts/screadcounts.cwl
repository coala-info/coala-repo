cwlVersion: v1.2
class: CommandLineTool
baseCommand: screadcounts
label: screadcounts
doc: "The provided text is a system error log indicating a failure to build or extract
  a container image (no space left on device) and does not contain the help text or
  usage information for the tool 'screadcounts'.\n\nTool homepage: https://github.com/HorvathLab/NGS/tree/master/SCReadCounts#readme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screadcounts:1.4.2--hdfd78af_0
stdout: screadcounts.out
