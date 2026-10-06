cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amptk
  - primers
label: amptk_primers
doc: "Primers hard-coded into AMPtk\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: List of primer names and sequences hard-coded in AMPtk
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_primers.out
