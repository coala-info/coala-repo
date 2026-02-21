cwlVersion: v1.2
class: CommandLineTool
baseCommand: profnet-md
label: profnet-md
doc: The provided text does not contain help information or a description of the tool;
  it contains container runtime error logs.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profnet-md:v1.0.22-6-deb_cv1
stdout: profnet-md.out
