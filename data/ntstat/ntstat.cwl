cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntstat
label: ntstat
doc: "A tool for calculating nucleotide statistics (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/bcgsc/ntStat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2
stdout: ntstat.out
