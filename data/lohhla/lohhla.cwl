cwlVersion: v1.2
class: CommandLineTool
baseCommand: lohhla
label: lohhla
doc: "Loss of Heterozygosity in Human Leukocyte Antigen (LOHHLA) analysis tool. Note:
  The provided help text contains only container runtime error messages and does not
  list specific command-line arguments.\n\nTool homepage: https://bitbucket.org/mcgranahanlab/lohhla"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lohhla:20171108--r3.4.1_0
stdout: lohhla.out
