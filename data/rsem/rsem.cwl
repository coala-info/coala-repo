cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem
label: rsem
doc: "The provided text does not contain help information for RSEM; it is an error
  log from a container build process (Singularity/Apptainer) attempting to fetch the
  RSEM image.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
stdout: rsem.out
