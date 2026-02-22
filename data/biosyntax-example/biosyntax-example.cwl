cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosyntax-example
label: biosyntax-example
doc: The provided text does not contain help information or usage instructions; 
  it consists of system error messages related to a failed container image 
  download (no space left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosyntax-example:v1.0.0b-1-deb_cv1
stdout: biosyntax-example.out
