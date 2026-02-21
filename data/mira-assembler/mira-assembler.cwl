cwlVersion: v1.2
class: CommandLineTool
baseCommand: mira
label: mira-assembler
doc: "MIRA is a multi-purpose genome assembly and mapping tool for whole genome sequencing
  and EST/RNASeq projects.\n\nTool homepage: https://github.com/DrMicrobit/mira"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mira-assembler:v4.9.6-2-deb_cv1
stdout: mira-assembler.out
