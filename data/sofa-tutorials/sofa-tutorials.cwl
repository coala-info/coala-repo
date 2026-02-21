cwlVersion: v1.2
class: CommandLineTool
baseCommand: sofa-tutorials
label: sofa-tutorials
doc: "The provided text does not contain help information or usage instructions; it
  consists of log messages from a failed container build process for the sofa-tutorials
  image.\n\nTool homepage: https://github.com/sebastiennelissen/Tutorials"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sofa-tutorials:v1.0beta4-12-deb_cv1
stdout: sofa-tutorials.out
