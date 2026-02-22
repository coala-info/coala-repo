cwlVersion: v1.2
class: CommandLineTool
baseCommand: sitplus-data
label: sitplus-data
doc: Data package for SITPLUS, a free software framework for ludic-therapeutic 
  interaction.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sitplus-data:v1.0.3-5.1-deb_cv1
stdout: sitplus-data.out
