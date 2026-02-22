cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosquid-dev
label: biosquid-dev
doc: The provided text contains system error logs related to a container 
  execution failure (no space left on device) rather than the help documentation
  for the tool. Consequently, no arguments or tool descriptions could be 
  extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosquid-dev:v1.9gcvs20050121-7-deb_cv1
stdout: biosquid-dev.out
