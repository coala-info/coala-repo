cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_configGenerator
label: sipros_configGenerator
doc: "The provided text does not contain help information or usage instructions for
  sipros_configGenerator. It consists of Singularity/Apptainer runtime logs and a
  fatal error message regarding a container build failure.\n\nTool homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_configGenerator.out
