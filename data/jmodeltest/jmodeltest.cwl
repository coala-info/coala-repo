cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmodeltest
label: jmodeltest
doc: "The provided text does not contain help information or usage instructions for
  jmodeltest; it contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: https://github.com/ddarriba/jmodeltest2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jmodeltest:v2.1.10dfsg-7-deb_cv1
stdout: jmodeltest.out
