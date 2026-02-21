cwlVersion: v1.2
class: CommandLineTool
baseCommand: diatracer
label: diatracer_java
doc: "A tool for DIA (Data-Independent Acquisition) proteomics data analysis. Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: https://diatracer.nesvilab.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diatracer:1.2.5--h9ee0642_0
stdout: diatracer_java.out
