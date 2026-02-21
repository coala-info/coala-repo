cwlVersion: v1.2
class: CommandLineTool
baseCommand: theseus_pkg-config
label: theseus_pkg-config
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process (Apptainer/Singularity)
  while attempting to fetch a Docker image.\n\nTool homepage: https://github.com/theseus-os/Theseus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/theseus:v3.3.0-8-deb_cv1
stdout: theseus_pkg-config.out
