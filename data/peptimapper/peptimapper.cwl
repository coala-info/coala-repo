cwlVersion: v1.2
class: CommandLineTool
baseCommand: peptimapper
label: peptimapper
doc: PeptiMapper tool (Help text unavailable in provided output)
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/peptimapper:v2.0.0_cv1
stdout: peptimapper.out
