cwlVersion: v1.2
class: CommandLineTool
baseCommand: univariate
label: univariate
doc: "A tool for univariate analysis (Note: The provided text appears to be a container
  build log rather than help text, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/ServiceNow/N-BEATS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/univariate:phenomenal-v2.2.6_cv1.3.32
stdout: univariate.out
