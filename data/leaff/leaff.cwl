cwlVersion: v1.2
class: CommandLineTool
baseCommand: leaff
label: leaff
doc: "The provided text appears to be a system error log from a container build process
  rather than the help documentation for the 'leaff' tool. As a result, specific arguments
  and descriptions could not be extracted from this input.\n\nTool homepage: https://github.com/alexjbest/leaff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/leaff:v020150903r2013-6-deb_cv1
stdout: leaff.out
