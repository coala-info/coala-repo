cwlVersion: v1.2
class: CommandLineTool
baseCommand: diatracer
label: diatracer
doc: "A tool for DIA (Data-Independent Acquisition) proteomics data analysis (Note:
  The provided text contains only container runtime error logs and no help documentation;
  arguments could not be extracted).\n\nTool homepage: https://diatracer.nesvilab.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diatracer:1.2.5--h9ee0642_0
stdout: diatracer.out
