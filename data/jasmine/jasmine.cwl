cwlVersion: v1.2
class: CommandLineTool
baseCommand: jasmine
label: jasmine
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool 'jasmine'.\n
  \nTool homepage: https://bitbucket.org/bipous/jasmine/src/master"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jasmine:1.1--0
stdout: jasmine.out
