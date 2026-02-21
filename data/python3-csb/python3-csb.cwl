cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-csb
label: python3-csb
doc: 'Computational Structural Biology toolbox (Note: The provided text is a container
  build log and does not contain usage information or argument definitions.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-csb:v1.2.3dfsg-3-deb_cv1
stdout: python3-csb.out
