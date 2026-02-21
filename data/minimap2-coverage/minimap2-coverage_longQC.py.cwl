cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap2-coverage_longQC.py
label: minimap2-coverage_longQC.py
doc: "A tool for calculating coverage, likely associated with the LongQC quality control
  pipeline. (Note: The provided input text contains container execution error logs
  rather than help documentation, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/yfukasawa/LongQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimap2-coverage:1.2.0c--h577a1d6_4
stdout: minimap2-coverage_longQC.py.out
