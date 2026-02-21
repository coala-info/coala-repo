cwlVersion: v1.2
class: CommandLineTool
baseCommand: simlord
label: simlord
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system log showing a container build failure.\n\nTool homepage:
  https://bitbucket.org/genomeinformatics/simlord/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simlord:1.0.4--py37hf01694f_1
stdout: simlord.out
