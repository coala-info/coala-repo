cwlVersion: v1.2
class: CommandLineTool
baseCommand: trace2dbest
label: trace2dbest
doc: The provided text does not contain help information or a description of the tool;
  it contains container runtime logs and a fatal error message regarding image retrieval.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/trace2dbest:v3.0.1-1-deb_cv1
stdout: trace2dbest.out
