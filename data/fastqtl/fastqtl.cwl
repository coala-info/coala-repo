cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqtl
label: fastqtl
doc: "The provided text is a container execution log and does not contain help information
  or argument definitions for the fastqtl tool.\n\nTool homepage: https://github.com/francois-a/fastqtl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastqtl:v2.184dfsg-5-deb_cv1
stdout: fastqtl.out
