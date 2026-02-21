cwlVersion: v1.2
class: CommandLineTool
baseCommand: itsx
label: itsx
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: http://microbiology.se/software/itsx/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itsx:1.1.3--hdfd78af_1
stdout: itsx.out
