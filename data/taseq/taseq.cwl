cwlVersion: v1.2
class: CommandLineTool
baseCommand: taseq
label: taseq
doc: "The provided text does not contain help information or usage instructions for
  the tool 'taseq'. It appears to be a set of error logs from a container build process
  (Apptainer/Singularity) failing to fetch a Docker image.\n\nTool homepage: https://github.com/KChigira/taseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taseq:1.1.1--pyh7e72e81_0
stdout: taseq.out
