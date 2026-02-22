cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbgenomicconsensus
label: pbgenomicconsensus
doc: The provided text does not contain help information for the tool. It 
  consists of system error messages related to a lack of disk space during a 
  container execution attempt.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbgenomicconsensus:v2.3.2-5-deb-py2_cv1
stdout: pbgenomicconsensus.out
