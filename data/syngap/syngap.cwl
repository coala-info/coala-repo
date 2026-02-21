cwlVersion: v1.2
class: CommandLineTool
baseCommand: syngap
label: syngap
doc: "The provided text does not contain help information or usage instructions for
  the tool 'syngap'. It appears to be an error log from a container runtime (Singularity/Apptainer)
  failing to fetch a Docker image.\n\nTool homepage: https://github.com/yanyew/SynGAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
stdout: syngap.out
