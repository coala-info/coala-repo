cwlVersion: v1.2
class: CommandLineTool
baseCommand: nutsqlite
label: nutsqlite
doc: The provided text does not contain help information or a description of the tool;
  it is an error log reporting a failure to build a container image due to insufficient
  disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/nutsqlite:v2.0.6-1-deb_cv1
stdout: nutsqlite.out
