cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastdnaml
label: fastdnaml
doc: The provided text is a container build log and does not contain the help 
  documentation or usage instructions for the fastdnaml tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastdnaml:v1.2.2-14-deb_cv1
stdout: fastdnaml.out
