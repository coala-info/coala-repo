cwlVersion: v1.2
class: CommandLineTool
baseCommand: sem
label: sem
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sem'. It is a system log indicating a failure to build or extract a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/YenLab/SEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sem:1.2.3--hdfd78af_0
stdout: sem.out
