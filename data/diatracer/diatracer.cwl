cwlVersion: v1.2
class: CommandLineTool
baseCommand: diatracer
label: diatracer
doc: "Please provide pass a license key with the --key argument. You may obtain a
  key by agreeing to the terms at msfragger-upgrader.nesvilab.org/diatracer/.\n\n\
  Tool homepage: https://diatracer.nesvilab.org/"
inputs:
  - id: key
    type: string
    doc: license key
    inputBinding:
      position: 101
      prefix: --key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diatracer:1.2.5--h9ee0642_0
stdout: diatracer.out
