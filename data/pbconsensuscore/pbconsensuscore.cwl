cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbconsensuscore
label: pbconsensuscore
doc: The provided text does not contain help information or documentation for 
  the tool; it consists of system error messages indicating a failure to pull or
  build a container image due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbconsensuscore:v1.1.1dfsg-1-deb-py3_cv1
stdout: pbconsensuscore.out
