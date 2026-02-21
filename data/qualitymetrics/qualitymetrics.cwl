cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualitymetrics
label: qualitymetrics
doc: "A tool for calculating quality metrics (Note: The provided text appears to be
  a container build error log rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/SteinmetzLab/qualityMetrics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qualitymetrics:phenomenal-v2.2.11_cv1.0.11
stdout: qualitymetrics.out
