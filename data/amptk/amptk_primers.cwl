cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk_primers
label: amptk_primers
doc: "Primers hard-coded into AMPtk\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: primer_name
    type: string
    doc: Name of the primer to use
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_primers.out
