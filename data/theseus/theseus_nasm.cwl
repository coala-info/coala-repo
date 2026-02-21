cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus_nasm
label: theseus_nasm
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process (Apptainer/Singularity) attempting
  to fetch a Docker image.\n\nTool homepage: https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_nasm.out
