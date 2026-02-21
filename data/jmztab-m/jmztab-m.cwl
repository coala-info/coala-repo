cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmztab-m
label: jmztab-m
doc: "A tool for processing and validating mzTab-m files (a standard format for metabolomics
  results). Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  https://github.com/lifs-tools/jmztab-m"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jmztab-m:1.0.6--hdfd78af_1
stdout: jmztab-m.out
