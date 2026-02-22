cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools-data
label: poretools-data
doc: The provided text contains system error messages related to container 
  execution and disk space issues rather than the help documentation for the 
  tool. Consequently, no arguments or functional descriptions could be 
  extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/poretools-data:v0.6.0dfsg-3-deb_cv1
stdout: poretools-data.out
